defmodule StarDiaries.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias StarDiaries.Repo

  alias StarDiaries.Accounts.User
  alias StarDiaries.Accounts.Users
  alias StarDiaries.Accounts.UsersFromAuth
  alias StarDiaries.Accounts.Authentication

  def get_user(id), do: Users.get_user(id)

  def get_user_by(clauses), do: Users.get_user_by(clauses)

  def create_user(attrs \\ %{}), do: Users.create(attrs)

  def get_or_insert_user_from_auth(%Ueberauth.Auth{} = auth) do
    UsersFromAuth.get_or_insert(auth)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> create_user_changeset(user)
      %Ecto.Changeset{source: %User{}}

  """
  def create_user_changeset(%User{} = user) do
    User.create_changeset(user, %{})
  end

  def auth_valid?(email, password) do
    Authentication.valid?(email, password)
  end
end
