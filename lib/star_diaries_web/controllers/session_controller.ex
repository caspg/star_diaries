defmodule StarDiariesWeb.SessionController do
  use StarDiariesWeb, :controller

  alias StarDiaries.Accounts

  plug(StarDiariesWeb.Plugs.EnsureUnLogged when action in [:new, :create])
  plug(StarDiariesWeb.Plugs.EnsureLoggedIn when action in [:delete])

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Accounts.auth_valid?(email, password) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "All good.")
        |> put_session(:current_user_id, user.id)
        |> redirect(to: "/")

      :error ->
        conn
        |> put_flash(:error, "invalid credentials!")
        |> render("new.html")
    end
  end

  def delete(%Plug.Conn{assigns: %{current_user: current_user}} = conn, _params) do
    conn
    |> clear_session
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end
end
