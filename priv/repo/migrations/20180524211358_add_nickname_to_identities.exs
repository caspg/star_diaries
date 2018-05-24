defmodule StarDiaries.Repo.Migrations.AddNicknameToIdentities do
  use Ecto.Migration

  def change do
    alter table(:identities) do
      add :nickname, :string
    end
  end
end
