defmodule StarDiaries.Accounts.UsersFromAuthTest do
  use StarDiaries.DataCase

  alias StarDiaries.Repo
  alias StarDiaries.Accounts.UsersFromAuth
  alias StarDiaries.Accounts.User
  alias StarDiaries.Accounts.Users
  alias StarDiaries.Accounts.Identities

  @user_email "email@email.com"
  @valid_user_attrs %{email: @user_email, name: "some name"}
  @valid_identity_attrs %{
    uid: "42",
    provider: "github",
    token: "123"
  }

  @ueberauth %Ueberauth.Auth{
    uid: @valid_identity_attrs.uid,
    provider: @valid_identity_attrs.provider,
    info: %Ueberauth.Auth.Info{
      email: @user_email,
      name: "My name"
    },
    credentials: %Ueberauth.Auth.Credentials{
      token: @valid_identity_attrs.token
    }
  }

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@valid_user_attrs)
      |> Users.create_user_from_identity()

    user
  end

  def identity_fixture(user, attrs \\ %{}) do
    attrs = Enum.into(attrs, @valid_identity_attrs)
    {:ok, identity} = Identities.create_with_user(user, attrs)
    identity
  end

  describe "get_or_insert/1" do
    test "create user and identity" do
      assert {:ok, %User{} = user} = UsersFromAuth.get_or_insert(@ueberauth)

      user = Repo.preload(user, :identities)
      identity = user.identities |> List.last()

      assert user.email == @ueberauth.info.email
      assert user.name == @ueberauth.info.name
      assert identity.token == @ueberauth.credentials.token
      assert identity.provider == to_string(@ueberauth.provider)
      assert identity.uid == to_string(@ueberauth.uid)
    end

    test "associate identity to the existing user" do
      user = user_fixture()

      assert {:ok, %User{} = user_from_auth} = UsersFromAuth.get_or_insert(@ueberauth)
      assert Repo.all(User) |> length == 1
      assert user == user_from_auth

      user = Repo.preload(user, :identities)
      identity = user.identities |> List.last()

      assert identity.token == @ueberauth.credentials.token
      assert identity.provider == to_string(@ueberauth.provider)
      assert identity.uid == to_string(@ueberauth.uid)
    end

    test "associate identities to the existing user" do
      # TODO
    end

    test "returns user associated to the existing identity" do
      user = user_fixture()
      identity = identity_fixture(user)

      assert {:ok, %User{} = user_from_auth} = UsersFromAuth.get_or_insert(@ueberauth)
      assert user_from_auth == user

      user_from_auth = Repo.preload(user_from_auth, :identities)

      assert user_from_auth.identities |> List.last() == identity
    end
  end
end
