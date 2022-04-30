defmodule Pratipad.Example.Server.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Pratipad.Example.Server.Client,
       [
         name: :pratipad_example_server,
         forwarder_name: :pratipad_backwarder_input,
         backwarder_name: :pratipad_forwarder_output,
         connection_mode: :server
       ]},
      {Pratipad.Example.Server.Repo, []}
    ]

    opts = [strategy: :one_for_one, name: Pratipad.Example.Server.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
