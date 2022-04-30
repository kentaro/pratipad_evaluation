import Config

config :pratipad_example_server,
  ecto_repos: [Pratipad.Example.Server.Repo]

config :pratipad_example_server, Pratipad.Example.Server.Repo,
  adapter: Ecto.Adapters.MyXQL,
  database: "pratipad_example",
  username: "pratipad",
  password: "pratipad",
  hostname: "localhost"

config :livebook, LivebookWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 8080],
  server: true,
  pubsub_server: Livebook.PubSub,
  secret_key_base: "16Eu4wSifR2B7VPnikQdWsSh+lf0havzFj5JdC42VgeS4FFr4VU/lgzJ4ptZjMP5",
  live_view: [signing_salt: "pratipad"]

config :livebook,
  default_runtime: {Livebook.Runtime.Embedded, []},
  authentication_mode: :disabled

config :livebook,
       :cookie,
       :pratipad_cookie

config :livebook,
  root_path: "./livebooks"

config :phoenix, :json_library, Jason
