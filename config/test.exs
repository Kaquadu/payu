use Mix.Config

# Configure your database
config :book_shop, BookShop.Repo,
  username: "postgres",
  password: "postgres",
  database: "book_shop_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :book_shop, BookShopWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
