defmodule Pratipad.Example.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    connect_node()

    children = [
      # Start the Telemetry supervisor
      PratipadExampleWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PratipadExample.PubSub},
      # Start the Endpoint (http/https)
      PratipadExampleWeb.Endpoint,

      # Pratipad
      {Pratipad, nil}
    ]

    opts = [strategy: :one_for_one, name: Pratipad.Example.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PratipadExampleWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp connect_node() do
    server_node = Application.fetch_env!(:pratipad_example, :server_node)
    Node.connect(server_node)
  end
end
