defmodule StarDiariesWeb.AuthController.Logout do
  use StarDiariesWeb, :controller

  def call(%Plug.Conn{assigns: %{current_user: nil}} = conn) do
    conn
    |> put_flash(:info, "Already logged out")
    |> redirect(to: "/")
  end

  def call(%Plug.Conn{assigns: %{current_user: current_user}} = conn) do
    conn
    |> clear_session
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end
end
