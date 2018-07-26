use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :star_diaries, StarDiariesWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :star_diaries, StarDiaries.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "star_diaries_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :star_diaries, :bcrypt, StarDiariesWeb.BcryptMock

config :star_diaries, :emails,
  from_email: "test_from@email.com"

config :star_diaries, StarDiaries.Emails.Mailer,
  adapter: Bamboo.TestAdapter
