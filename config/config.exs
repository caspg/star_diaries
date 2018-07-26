# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :star_diaries, ecto_repos: [StarDiaries.Repo]

config :star_diaries, :bcrypt, Comeonin.Bcrypt

# Configures the endpoint
config :star_diaries, StarDiariesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3iEjrMQLPNmcVAviDrJ0jBlUpSAVmmg2zN3mADX5OpEKL7fgTv7+ENiYKSPhrQRl",
  render_errors: [view: StarDiariesWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: StarDiaries.PubSub, adapter: Phoenix.PubSub.PG2]

config :star_diaries, StarDiaries.Emails.Mailer,
  adapter: Bamboo.LocalAdapter

config :star_diaries, :emails,
  from_email: "star_diaries@todo.com"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix and Ecto
config :phoenix, :json_library, Jason
config :ecto, :json_library, Jason

# ueberauth_github is using oauth2 and it requires to specify serializer
config :oauth2,
  serializers: %{
    "application/json" => Jason
  }

config :ueberauth, Ueberauth,
  providers: [
    #  read-only access to public information
    github: {Ueberauth.Strategy.Github, [default_scope: ""]},
    twitter: {Ueberauth.Strategy.Twitter, []}
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")

config :ueberauth, Ueberauth.Strategy.Twitter.OAuth,
  consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
  consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
