defmodule StarDiaries.Accounts.Users do
  import Ecto.Query, warn: false

  alias __MODULE__
  alias StarDiaries.Repo
  alias StarDiaries.Accounts.User
  alias StarDiaries.Accounts.Users.Authentication
  alias StarDiaries.SecureRandom
  alias StarDiaries.Helpers
  alias StarDiaries.Accounts.Users.UseCases

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  def get_user(id), do: Repo.get(User, id)

  def get_by(clauses), do: Repo.get_by(User, clauses)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_from_identity(attrs \\ %{}) do
    attrs = attrs
            |> Helpers.key_to_atom()
            |> Map.put(:confirmed_at, NaiveDateTime.utc_now())

    %User{}
    |> User.changeset_from_identity(attrs)
    |> Repo.insert()
  end

  def create(attrs \\ %{}) do
    attrs = attrs
            |> Helpers.key_to_atom()
            |> put_confirmation_token()

    %User{}
    |> User.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def update(%User{} = user, attrs) do
    user
    |> User.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Confirms a User.

  ## Examples

      iex> confirm(user, confirmed_at)
      {:ok, %User{}}

      iex> confirm(user, confirmed_at)
      {:error, %Ecto.Changeset{}}

  """
  def confirm(user, confirmed_at) do
    attrs = %{
      confirmed_at: confirmed_at,
      confirmation_token: nil
    }

    user
    |> Users.update(attrs)
  end

  def confirmed?(user) do
    user.confirmed_at != nil
  end

  defp put_confirmation_token(%{} = attrs) do
    confirmation_token = SecureRandom.generate()

    attrs
    |> Map.put(:confirmation_token, confirmation_token)
  end
end
