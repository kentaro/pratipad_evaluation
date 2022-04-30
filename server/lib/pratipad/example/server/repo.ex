defmodule Pratipad.Example.Server.Repo do
  use Ecto.Repo,
    otp_app: :pratipad_example_server,
    adapter: Ecto.Adapters.MyXQL
end
