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

    Process.send_after(self(), :stop, opts[:duration])
    start_processes(opts[:type], opts[:num])

    {:ok,
     %{
       start: Time.utc_now(),
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

  defp start_processes(:demand, num) do
    1..num
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

  defp start_processes(:push, num) do
    1..num
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

      GenServer.cast(pid, :start_push_message)
    end)
  end
end
