defmodule StarDiaries.Accounts.Identity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "identities" do
    field :provider, :string
    field :uid, :string
    field :token, :string

    belongs_to :user, StarDiaries.Accounts.User

    timestamps()
  end

  def changeset(identity, %{} = attrs) do
    identity
    |> cast(attrs, [:provider, :uid, :token, :user_id])
    |> validate_required([:provider, :uid, :token])
    |> assoc_constraint(:user)
  end
end
