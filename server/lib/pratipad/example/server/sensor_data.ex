defmodule Pratipad.Example.Server.SensorData do
  use Ecto.Schema

  schema "sensor_data" do
    field(:co2_concentration, :integer)
    field(:humidity_rh, :float)
    field(:pressure_pa, :float)
    field(:temperature_c, :float)
    field(:precipitation, :float)
    field(:device_id, :string)
    field(:measured_at, :naive_datetime)
  end
end
