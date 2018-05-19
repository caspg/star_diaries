defmodule StarDiaries.Repo.Migrations.AuthorizationBelongsToUser do
  use Ecto.Migration

  def change do
    alter table(:authorizations) do
      add :user_id, references(:users)
    end
  end
end
