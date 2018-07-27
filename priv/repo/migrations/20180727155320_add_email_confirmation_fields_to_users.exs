defmodule StarDiaries.Repo.Migrations.AddEmailConfirmationFieldsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :confirmation_token, :string
      add :confirmation_sent_at, :naive_datetime
      add :confirmed_at, :naive_datetime
    end

    create unique_index(:users, [:confirmation_token])
    create index(:users, [:confirmed_at])
  end
end
