defmodule StarDiaries.IdentitiesTest do
  use StarDiaries.DataCase

  alias StarDiaries.Repo
  alias StarDiaries.Accounts.Users
  alias StarDiaries.Accounts.Identity
  alias StarDiaries.Accounts.Identities

  @valid_user_attrs %{email: "some email", name: "some name"}
  @valid_identity_attrs %{provider: "hogwart", uid: "13", token: "11"}

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@valid_user_attrs)
      |> Users.create_user_from_identity()

    user
  end

  describe "create_with_user/2" do
    test "creates identity with valid data" do
      user = user_fixture()

      assert {:ok, %Identity{} = identity} =
               Identities.create_with_user(user, @valid_identity_attrs)

      assert identity.provider == @valid_identity_attrs.provider
      assert identity.uid == @valid_identity_attrs.uid
      assert identity.token == @valid_identity_attrs.token

      identity = Repo.preload(identity, :user)
      assert identity.user == user
    end

    test "returns error with invalid data" do
      user = user_fixture()
      invalid_attrs = %{provider: nil, uid: nil, token: nil}

      assert {:error, %Ecto.Changeset{}} = Identities.create_with_user(user, invalid_attrs)
    end

    test "validating unique provider_uid_index constraint" do
      user = user_fixture()

      assert {:ok, _} = Identities.create_with_user(user, @valid_identity_attrs)
      assert {:error, reason} = Identities.create_with_user(user, @valid_identity_attrs)
      assert reason.errors == [provider_uid_index: {"has already been taken", []}]
    end
  end
end
