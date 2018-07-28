defmodule StarDiaries.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @bcrypt Application.get_env(:star_diaries, :bcrypt)

  schema "users" do
    field(:email, :string)
    field(:name, :string)
    field(:encrypted_password, :string)
    field(:confirmation_token, :string)
    field(:confirmation_sent_at, :naive_datetime)
    field(:confirmed_at, :naive_datetime)

    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)

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

  def create_changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :password_confirmation, :confirmation_token])
    |> validate_required([:email, :password, :password_confirmation, :confirmation_token])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> validate_format(:password, ~r/[0-9]+/, message: "must contain a number")
    |> validate_format(:password, ~r/[A-Z]+/, message: "must contain an upper-case letter")
    |> validate_format(:password, ~r/[a-z]+/, message: "must contain a lower-case letter")
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
        |> put_change(:encrypted_password, @bcrypt.hashpwsalt(password))

      _ ->
        changeset
    end
  end
end
