defmodule StarDiaries.Accounts.UsersTest do
  use StarDiaries.DataCase

  alias StarDiaries.Accounts.Users

  @bcrypt Application.get_env(:star_diaries, :bcrypt)

  describe "users" do
    alias StarDiaries.Accounts.User

    @valid_attrs %{email: "some email", name: "some name"}
    @update_attrs %{email: "some updated email", name: "some updated name"}
    @invalid_attrs %{email: nil, name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user_from_identity()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user_from_identity/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user_from_identity(@valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
    end

    test "create_user_from_identity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user_from_identity(@invalid_attrs)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "create/1 with valid data creates user" do
      attrs = %{
        email: "some@email.com",
        password: "password",
        password_confirmation: "password"
      }

      assert {:ok, %User{} = user} = Users.create(attrs)
      assert user.encrypted_password == @bcrypt.hashpwsalt(attrs.password)
    end
  end
end
