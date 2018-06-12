defmodule StarDiaries.Repo.Migrations.AddEncryptedPasswordToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :add_encrypted_password, :string
    end
  end
end
