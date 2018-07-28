defmodule StarDiaries.Accounts.UsersCreateTest do
  use StarDiaries.DataCase

  alias StarDiaries.Accounts.Users
  alias StarDiaries.Accounts.User
  alias StarDiariesWeb.ErrorHelpers

  @bcrypt Application.get_env(:star_diaries, :bcrypt)

  describe "Users.create/1" do
    @valid_attrs %{
      email: "some@email.com",
      password: "Password1",
      password_confirmation: "Password1"
    }

    test "creates user with valid data " do
      assert {:ok, %User{} = user} = Users.create(@valid_attrs)
      assert user.encrypted_password == @bcrypt.hashpwsalt(@valid_attrs.password)
      assert user.confirmation_token != nil
    end

    test "email validation" do
      attrs = @valid_attrs |> Map.put(:email, "invalid_email")

      assert {:error, changeset} = Users.create(attrs)
      assert changeset.errors[:email] |> ErrorHelpers.translate_error() == "has invalid format"
    end

    test "password length validation" do
      attrs =
        @valid_attrs
        |> Map.put(:password, "Short1")
        |> Map.put(:password_confirmation, "Short1")

      assert {:error, changeset} = Users.create(attrs)

      assert changeset.errors[:password] |> ErrorHelpers.translate_error() ==
               "should be at least 8 character(s)"
    end

    test "password format validation" do
      attrs =
        @valid_attrs
        |> Map.put(:password, "Password")
        |> Map.put(:password_confirmation, "Password")

      assert {:error, changeset} = Users.create(attrs)

      assert changeset.errors[:password] |> ErrorHelpers.translate_error() ==
               "must contain a number"
    end

    test "password confirmation validation" do
      attrs = @valid_attrs |> Map.put(:password_confirmation, "yo")

      assert {:error, changeset} = Users.create(attrs)

      assert changeset.errors[:password_confirmation] |> ErrorHelpers.translate_error() ==
               "does not match confirmation"
    end

    test "email uniqueness validation" do
      assert {:ok, %User{}} = Users.create(@valid_attrs)
      assert {:error, changeset} = Users.create(@valid_attrs)

      assert changeset.errors[:email] |> ErrorHelpers.translate_error() ==
               "has already been taken"
    end
  end
end
