defmodule StarDiariesWeb.SessionController do
  use StarDiariesWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def delete(%Plug.Conn{assigns: %{current_user: nil}} = conn, _params) do
    conn
    |> put_flash(:info, "Already logged out")
    |> redirect(to: "/")
  end

  def delete(%Plug.Conn{assigns: %{current_user: current_user}} = conn, _params) do
    conn
    |> clear_session
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end
end
