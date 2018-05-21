defmodule StarDiaries.Accounts.UsersFromAuthTest do
  use StarDiaries.DataCase

  alias StarDiaries.Repo
  alias StarDiaries.Accounts.UsersFromAuth
  alias StarDiaries.Accounts.User

  @ueberauth %Ueberauth.Auth{
    uid: "4242",
    provider: :github,
    info: %Ueberauth.Auth.Info{
      email: "some@email.pl",
      name: "My name"
    },
    credentials: %Ueberauth.Auth.Credentials{
      token: "123"
    }
  }

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
  end
end
