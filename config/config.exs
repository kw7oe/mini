import Config

config :logger, :console, metadata: [:request_id]

config :mini,
  port: System.fetch_env!("PORT") || "4000"
