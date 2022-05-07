defmodule Pratipad.Example.Device.Push do
  use Pratipad.Client, mode: :push, backward_enabled: false
  alias Pratipad.Client.Push

  @interval 1000

  @impl GenServer
  def handle_cast({:start_push_message, opts}, state) do
    send(self(), :loop_push_message)
    Process.send_after(self(), :stop_push_message, opts[:duration])
    {:noreply, state}
  end

  @impl GenServer
  def handle_info(:loop_push_message, state) do
    GenServer.cast(self(), :push_message)
    timer = Process.send_after(self(), :loop_push_message, @interval)
    {:noreply, Map.put(state, :timer, timer)}
  end

  @impl GenServer
  def handle_info(:stop_push_message, state) do
    Process.cancel_timer(state.timer)
    {:noreply, Map.put(state, :timer, nil)}
  end

  @impl Push
  def push_message() do
    %{
      humidity_rh: 30.0,
      pressure_pa: 1000.0,
      temperature_c: 30.0,
      co2_concentration: 800,
      measured_at: NaiveDateTime.local_now()
    }
  end
end
