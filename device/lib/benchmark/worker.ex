defmodule Benchmark.Worker do
  use GenServer

  @supervisor Pratipad.Example.Device.DynamicSupervisor

  @impl GenServer
  def init(opts) do
    {:ok, pid} =
      DynamicSupervisor.start_link(
        strategy: :one_for_one,
        name: @supervisor,
        max_children: 10000
      )

    if opts[:type] == :demand do
      Process.send_after(self(), :stop, opts[:duration])
    end

    start_processes(opts[:type], opts)
    start_time = Time.utc_now()

    if opts[:type] == :push do
      Process.send_after(self(), :stop, opts[:duration])
    end

    {:ok,
     %{
       start: start_time,
       end: nil,
       supervisor: pid
     }}
  end

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl GenServer
  def handle_info(:stop, state) do
    DynamicSupervisor.stop(@supervisor)
    state = %{state | end: Time.utc_now()}
    IO.inspect(state)
    {:noreply, state}
  end

  @impl GenServer
  def handle_call(:count, _from, state) do
    count = DynamicSupervisor.count_children(@supervisor)
    {:reply, count, state}
  end

  defp start_processes(:demand, opts) do
    1..opts[:num]
    |> Enum.each(fn n ->
      device_name = :"pratipad_example_device_#{n}"

      DynamicSupervisor.start_child(@supervisor, {
        Pratipad.Example.Device.Demand,
        [
          name: device_name,
          forwarder_name: :pratipad_forwarder_input,
          connection_mode: :client
        ]
      })
    end)
  end

  defp start_processes(:push, opts) do
    1..opts[:num]
    |> Enum.each(fn n ->
      device_name = :"pratipad_example_device_#{n}"

      {:ok, pid} =
        DynamicSupervisor.start_child(@supervisor, {
          Pratipad.Example.Device.Push,
          [
            name: device_name,
            forwarder_name: :pratipad_forwarder_input,
            connection_mode: :client
          ]
        })

      GenServer.cast(pid, {:start_push_message, opts})
    end)
  end
end
