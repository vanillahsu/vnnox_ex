defmodule VNNOX.MixProject do
  use Mix.Project

  def project do
    [
      app: :vnnox_ex,
      version: "0.1.0",
      elixir: "~> 1.12",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "An Elixir client library for vnnox",
      source_url: "https://github.com/vanillahsu/vnnox_ex",
      preferred_cli_env: [
        vcr: :test,
        "vcr.delete": :test,
        "vcr.check": :test,
        "vcr.show": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison, :jason],
      mod: {VNNOX.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:httpoison_retry, "~> 1.1"},
      {:jason, "~> 1.2"},
      {:credo, "~> 1.5", only: [:dev], runtime: false},
      {:exvcr, "~> 0.13.2", only: :test, runtime: false}
    ]
  end
end
