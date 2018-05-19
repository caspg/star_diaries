defmodule StarDiariesWeb.Router do
  use StarDiariesWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StarDiariesWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Ueberauth authentication
  scope "/auth", StarDiariesWeb do
    pipe_through :browser # Use the default browser stack

    # request action is handled by Überauth
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end
end
