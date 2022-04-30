defmodule Pratipad.Example.Server.Client do
  use Pratipad.Client, mode: :push, backward_enabled: true
  alias Pratipad.Client

  @impl Client.Push
  def push_message() do
    :open_the_door
  end

  @impl Client.Backward
  def forward_message(message) do
    Logger.info("forward_message: #{inspect(message)}")

    data = %Pratipad.Example.Server.SensorData{
      co2_concentration: message.data.co2_concentration,
      humidity_rh: message.data.humidity_rh,
      pressure_pa: message.data.pressure_pa,
      temperature_c: message.data.temperature_c,
      precipitation: message.data.precipitation,
      device_id: message.data.device_id,
      measured_at: message.data.measured_at
    }

    Pratipad.Example.Server.Repo.insert(data)

    # Pushes a message if the conditions below meet.
    # The conditions mean the air is undesirable and you can open the door
    # because the rain outside is not so heavy.
    if message.data.co2_concentration > 800 && message.data.precipitation < 5 do
      GenServer.cast(self(), :push_message)
    end
  end
end
