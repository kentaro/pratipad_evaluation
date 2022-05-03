defmodule Pratipad.Example.Device.Demand do
  use Pratipad.Client, mode: :demand, backward_enabled: false
  alias Pratipad.Client.Demand

  @impl Demand
  def pull_message() do
    %{
      humidity_rh: 30.0,
      pressure_pa: 1000.0,
      temperature_c: 30.0,
      co2_concentration: 800,
      measured_at: NaiveDateTime.local_now()
    }
  end
end
