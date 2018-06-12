defmodule StarDiaries.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias StarDiaries.Repo

  alias StarDiaries.Accounts.User
  alias StarDiaries.Accounts.Users
  alias StarDiaries.Accounts.UsersFromAuth

  def get_user(id), do: Users.get_user(id)

  def get_user_by(clauses), do: Users.get_user_by(clauses)

  def create_user(attrs \\ %{}), do: Users.create(attrs)

  def get_or_insert_user_from_auth(%Ueberauth.Auth{} = auth) do
    UsersFromAuth.get_or_insert(auth)
  end
end
