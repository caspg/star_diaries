defmodule StarDiaries.Accounts.UsersFromAuthTest do
  use StarDiaries.DataCase

  alias StarDiaries.Accounts.UsersFromAuth
  alias StarDiaries.Repo

  describe "get_or_insert/1"  do
    test "create user and authorization" do
      auth = %Ueberauth.Auth{
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
      user = Repo.preload(user, :authorizations)

      require IEx
      IEx.pry

      assert user.email == auth.info.email
      assert user.name == auth.info.name
    end
  end
end
