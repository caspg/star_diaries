defmodule StarDiariesWeb.AuthController.Callback do
  use StarDiariesWeb, :controller

  alias StarDiaries.Accounts

  def call(%Plug.Conn{assigns: %{ueberauth_failure: _fails}} = conn) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def call(%Plug.Conn{assigns: %{ueberauth_auth: auth}} = conn) do
    {:ok, user} = Accounts.get_or_insert_user_from_auth(auth)

    conn
    |> put_flash(:info, "All good.")
    |> put_session(:current_user_id, user.id)
    |> redirect(to: "/")
  end
end
