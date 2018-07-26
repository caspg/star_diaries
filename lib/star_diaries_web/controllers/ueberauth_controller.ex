defmodule StarDiariesWeb.UeberauthController do
  @moduledoc """
  Handles the Überauth authentication.
  """

  alias StarDiaries.Accounts

  use StarDiariesWeb, :controller

  plug(Ueberauth)

  def callback(%Plug.Conn{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%Plug.Conn{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    {:ok, user} = Accounts.get_or_insert_user_from_auth(auth)

    conn
    |> put_flash(:info, "All good.")
    |> put_session(:current_user_id, user.id)
    |> redirect(to: "/")
  end
end
