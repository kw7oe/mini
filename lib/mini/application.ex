defmodule Mini.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  @port Application.get_env(:mini, :port)

  use Application
  require Logger

  def start(_type, _args) do
    Logger.info("Staring application at port #{@port}...")

    children = [
      {Plug.Cowboy, scheme: :http, plug: Mini.Router, options: [port: String.to_integer(@port)]}
      # Starts a worker by calling: Mini.Worker.start_link(arg)
      # {Mini.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mini.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
