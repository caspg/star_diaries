defmodule StarDiaries.Repo.Migrations.CreateAuthorizations do
  use Ecto.Migration

  def change do
    create table(:authorizations) do
      add :provider, :string
      add :token, :string
      add :refresh_token, :string
      add :expires_at, :integer

      timestamps()
    end

    create index(:authorizations, [:provider, :token], unique: true)
  end
end
