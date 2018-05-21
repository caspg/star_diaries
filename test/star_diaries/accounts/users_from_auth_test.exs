defmodule StarDiaries.Accounts.UsersFromAuthTest do
  use StarDiaries.DataCase

  alias StarDiaries.Repo
  alias StarDiaries.Accounts.UsersFromAuth
  alias StarDiaries.Accounts.User
  alias StarDiaries.Accounts.Users

  @user_email "email@email.com"
  @valid_user_attrs %{email: @user_email, name: "some name"}
  @ueberauth %Ueberauth.Auth{
    uid: "4242",
    provider: :github,
    info: %Ueberauth.Auth.Info{
      email: @user_email,
      name: "My name"
    },
    credentials: %Ueberauth.Auth.Credentials{
      token: "123"
    }
  }

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@valid_user_attrs)
      |> Users.create

    user
  end

  describe "get_or_insert/1"  do
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
      assert (Repo.all(User) |> length) == 1
      assert user == user_from_auth

      user = Repo.preload(user, :identities)
      identity = user.identities |> List.last()

      assert identity.token == @ueberauth.credentials.token
      assert identity.provider == to_string(@ueberauth.provider)
      assert identity.uid == to_string(@ueberauth.uid)
    end
  end
end
