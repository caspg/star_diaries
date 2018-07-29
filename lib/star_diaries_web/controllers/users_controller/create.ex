defmodule StarDiariesWeb.UsersController.Create do
  import Plug.Conn
  import Phoenix.Controller

  alias StarDiaries.Accounts
  alias StarDiariesWeb.Helpers.UserHelper

  def call(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        send_confirmation_email(conn, user)

      conn
        |> put_flash(:info, "All good.")
        |> put_session(:current_user_id, user.id)
        |> redirect(to: "/")

      {:error, %Ecto.Changeset{} = user_changeset} ->
        render(conn, "new.html", user_changeset: user_changeset)
    end
  end

  defp send_confirmation_email(conn, user) do
    url = UserHelper.generate_confirmation_url(user)
    Accounts.send_confirmation_email(user, url)
  end
end
