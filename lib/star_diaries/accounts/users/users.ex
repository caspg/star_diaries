defmodule StarDiaries.Accounts.Users do
  alias StarDiaries.Repo
  alias StarDiaries.Accounts.User

  def get_by(clauses) do
    Repo.get_by(User, clauses)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
