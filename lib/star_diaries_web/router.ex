defmodule StarDiariesWeb.Router do
  use StarDiariesWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(StarDiariesWeb.Plugs.SetCurrentUser)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", StarDiariesWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)

    get("/join", UsersController, :new)
    post("/join", UsersController, :create)

    get("/login", SessionController, :new)
    post("/login", SessionController, :create)

    delete("/logout", SessionController, :delete)
  end

  # Ueberauth authentication
  scope "/auth", StarDiariesWeb do
    # Use the default browser stack
    pipe_through(:browser)

    # request action is handled by Überauth
    get("/:provider", UeberauthController, :request)
    get("/:provider/callback", UeberauthController, :callback)
  end

  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end
end
