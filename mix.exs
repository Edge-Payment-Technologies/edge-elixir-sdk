defmodule EPTSDK.MixProject do
  use Mix.Project

  def project do
    [
      app: :ept_sdk,
      version: "11.0.1",
      description: "An SDK for interacting with the Edge Payment Technologies API",
      package: %{
        links: %{"GitHub" => "https://github.com/Edge-Payment-Technologies/edge-elixir-sdk"},
        licenses: ["MIT"]
      },
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {EPTSDK.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:req, "~> 0.5.0"},
      {:jason, "~> 1.4"},
      {:plug, "~> 1.15"},
      {:timex, "~> 3.7"},
      {:money, "~> 1.12"},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
