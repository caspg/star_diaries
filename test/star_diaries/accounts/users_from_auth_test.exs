defmodule StarDiaries.Accounts.UsersFromAuthTest do
  use StarDiaries.DataCase

  alias StarDiaries.Accounts.UsersFromAuthNew, as: UsersFromAuth
  alias StarDiaries.Repo

  describe "get_or_insert/1"  do
    test "create user and authorization" do
      auth = %Ueberauth.Auth{
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

      {:ok, user} = UsersFromAuth.get_or_insert(auth)
      user = Repo.preload(user, :identities)
      identity = user.identities |> List.last()

      assert user.email == auth.info.email
      assert user.name == auth.info.name
      assert identity.token == auth.credentials.token
      assert identity.provider == to_string(auth.provider)
      assert identity.uid == to_string(auth.uid)
    end
  end
end
