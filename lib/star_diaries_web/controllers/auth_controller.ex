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
    # TODO: handle error (redirect to root with flash message)
    {:ok, user} = Accounts.get_or_insert_user_from_auth(auth)

    conn
    |> put_flash(:info, "All good.")
    |> put_session(:current_user_id, user.id)
    |> redirect(to: "/")
  end
end
