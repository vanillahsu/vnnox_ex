defmodule VNNOX.Application do
  use Application

  def start(_type, _args) do
    children = [
      VNNOX.TokenState
    ]

    opts = [strategy: :one_for_one, name: VNNOX.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
