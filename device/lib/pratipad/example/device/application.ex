defmodule Pratipad.Example.Device.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    connect_node()

    children = []
    opts = [strategy: :one_for_one, name: Pratipad.Example.Device.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp connect_node() do
    Node.connect(:"dataflow@dataflow.pratipad.local")
  end
end
