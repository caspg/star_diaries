defmodule StarDiaries.Repo.Migrations.CreateIdentities do
  use Ecto.Migration

  def change do
    create table(:identities) do
      add :provider, :string
      add :token, :string
      add :uid, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:identities, [:provider, :uid], unique: true)
  end
end
