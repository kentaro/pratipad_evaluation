defmodule Pratipad.Example.Server.MixProject do
  use Mix.Project

  def project do
    [
      app: :pratipad_example_server,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Pratipad.Example.Server.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:pratipad_client, github: "kentaro/pratipad_client"},
      {:ecto_sql, "~> 3.6.2"},
      {:myxql, "~> 0.5.0"},
      {:livebook, "~> 0.2.0"},
      {:vega_lite, "~> 0.1.0"},
      {:kino, "~> 0.2.1"},
      {:jason, "~> 1.0"},
    ]
  end
end
