defmodule StarDiariesWeb.Plugs.EnsureUnLogged do
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  alias StarDiaries.Accounts.User

  def init(_options) do
  end

  def call(%Plug.Conn{assigns: %{current_user: nil}} = conn, _options) do
    conn
  end

  def call(%Plug.Conn{assigns: %{current_user: %User{}}} = conn, _options) do
    conn
    |> put_flash(:info, "You are already logged in.")
    |> redirect(to: "/")
  end
end
