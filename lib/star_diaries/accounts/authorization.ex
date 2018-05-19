defmodule StarDiaries.Accounts.Authorization do
  use Ecto.Schema
  import Ecto.Changeset

  schema "authorizations" do
    field :expires_at, :integer
    field :provider, :string
    field :refresh_token, :string
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(authorization, attrs) do
    authorization
    |> cast(attrs, [:provider, :token, :refresh_token, :expires_at])
    |> validate_required([:provider, :token, :refresh_token, :expires_at])
  end
end