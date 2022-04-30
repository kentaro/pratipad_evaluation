defmodule Pratipad.Example.Server.Repo.Migrations.CreateSensorData do
  use Ecto.Migration

  def up do
    create table(:sensor_data) do
      add :co2_concentration, :integer, null: false
      add :humidity_rh, :float, null: false
      add :pressure_pa, :float, null: false
      add :temperature_c, :float, null: false
      add :precipitation, :float, null: false
      add :device_id, :string, null: false
      add :measured_at, :naive_datetime, null: false
    end
  end

  def down do
    drop table(:sensor_data)
  end
end
