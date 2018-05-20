defmodule StarDiaries.Accounts.Authorizations do
  alias StarDiaries.Repo
  alias StarDiaries.Accounts.Authorization

  @spec get_by(clauses :: Keyword.t() | map()) :: %Authorization{} | nil

  def get_by(clauses) do
    Repo.get_by(Authorization, clauses)
  end

  def create_with_user(user, attrs) do
    user
    |> Ecto.build_assoc(:authorizations)
    |> Authorization.changeset(attrs)
    |> Repo.insert()
  end
end
