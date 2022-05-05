defmodule Pratipad.Example.Server.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Logger.configure(level: :info)
    :ets.new(:counter, [:set, :protected, :named_table])
    :ets.insert_new(:counter, {:count, 0})

    children = [
      {Pratipad.Example.Server.Client,
       [
         name: :pratipad_example_server,
         backwarder_name: :pratipad_forwarder_output,
         connection_mode: :server
       ]}
    ]

    opts = [strategy: :one_for_one, name: Pratipad.Example.Server.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
