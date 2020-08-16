import Config

config :logger, :console, metadata: [:request_id]

config :mini,
  port: "4000"
