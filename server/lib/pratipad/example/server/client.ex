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
    :ets.update_counter(:counter, :count, 1)
  end
end
