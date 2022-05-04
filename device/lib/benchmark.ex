defmodule Benchmark do
  @supervisor Pratipad.Example.Device.DynamicSupervisor

  def start(type, num) do
    DynamicSupervisor.start_link(
      strategy: :one_for_one,
      name: @supervisor,
      max_children: 10000
    )

    start_processes(type, num)
  end

  def start_processes(:demand, num) do
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

  def start_processes(:push, num) do
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

  def count() do
    DynamicSupervisor.count_children(@supervisor)
  end

  def stop() do
    DynamicSupervisor.stop(@supervisor)
  end
end
