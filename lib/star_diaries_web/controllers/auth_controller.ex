defmodule StarDiariesWeb.AuthController do
  @moduledoc """
  Handles the Überauth authentication.
  """

  alias StarDiaries.Accounts

  use StarDiariesWeb, :controller

  plug Ueberauth

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%Plug.Conn{assigns: %{ueberauth_auth: auth}} = conn, params) do
    Accounts.get_or_insert_user_from_auth(auth)
  end
end
