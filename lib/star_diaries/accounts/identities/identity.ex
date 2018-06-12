defmodule StarDiaries.Accounts.Identity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "identities" do
    field(:provider, :string)
    field(:uid, :string)
    field(:token, :string)
    field(:nickname, :string)

    belongs_to(:user, StarDiaries.Accounts.User)

    timestamps()
  end

  @required_create_fields ~w(
    provider
    uid
    token
    user_id
  )a

  def changeset(identity, %{} = attrs) do
    identity
    |> cast(attrs, @required_create_fields)
    |> validate_required(@required_create_fields)
    |> assoc_constraint(:user)
    |> unique_constraint(:provider_uid_index, name: :identities_provider_uid_index)
  end
end
