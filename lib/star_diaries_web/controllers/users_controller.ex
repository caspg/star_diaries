defmodule StarDiariesWeb.UsersController do
  use StarDiariesWeb, :controller

  alias StarDiaries.Accounts
  alias StarDiaries.Accounts.User

  plug(StarDiariesWeb.Plugs.EnsureUnLogged when action in [:new, :create])

  def new(conn, _params) do
    user_changeset = Accounts.create_user_changeset(%User{})
    render(conn, "new.html", user_changeset: user_changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "All good.")
        |> put_session(:current_user_id, user.id)
        |> redirect(to: "/")

      {:error, %Ecto.Changeset{} = user_changeset} ->
        render(conn, "new.html", user_changeset: user_changeset)
    end
  end
end
