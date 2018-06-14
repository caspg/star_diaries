defmodule StarDiaries.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:email, :string)
    field(:name, :string)
    field(:encrypted_password, :string)

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    has_many(:identities, StarDiaries.Accounts.Identity)

    timestamps()
  end

  @doc false
  def changeset_from_identity(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
  end

  # TODO(kacper): validate password format (1 number etc)
  # TODO(kacper): validate email format
  def create_changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :password_confirmation])
    |> validate_required([:email, :password, :password_confirmation])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> hash_password()
    |> unique_constraint(:email)
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        changeset
        |> delete_change(:password)
        |> delete_change(:password_confirmation)

      _ ->
        changeset
    end
  end
end
