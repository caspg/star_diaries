defmodule StarDiariesWeb.UsersController.New do
  import Phoenix.Controller

  alias StarDiaries.Accounts
  alias StarDiaries.Accounts.User

  def call(conn, _params) do
    user_changeset = Accounts.create_user_changeset(%User{})
    render(conn, "new.html", user_changeset: user_changeset)
  end
end
