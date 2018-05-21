defmodule StarDiaries.Accounts.Identities do
  alias StarDiaries.Repo
  alias StarDiaries.Accounts.Identity

  @spec get_by(clauses :: Keyword.t() | map()) :: %Identity{} | nil

  def get_by(clauses) do
    Repo.get_by(Identity, clauses)
  end

  def create_with_user(user, attrs) do
    user
    |> Ecto.build_assoc(:identities)
    |> Identity.changeset(attrs)
    |> Repo.insert()
  end
end
