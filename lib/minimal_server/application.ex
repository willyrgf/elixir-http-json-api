defmodule MinimalServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: MinimalServer.Worker.start_link(arg)
      # {MinimalServer.Worker, arg}
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: MinimalServer.Endpoint,
        options: [port: 4001]
      )
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MinimalServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
