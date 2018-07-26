defmodule StarDiaries.Accounts.AuthenticationTest do
  use StarDiaries.DataCase

  alias StarDiaries.Accounts.Authentication
  alias StarDiaries.Accounts

  describe "authentication" do
    @valid_password "Password1"
    @valid_email "email@email.com"

    def user_fixture do
      {:ok, user} =
        %{email: @valid_email, password: @valid_password, password_confirmation: @valid_password}
        |> Accounts.create_user()

      user
    end

    test "valid?/2 when given email is wrong" do
      user_fixture()
      assert :error == Authentication.valid?("invalid@email.com", @valid_password)
    end

    test "valid?/2 when given password is wrong" do
      user_fixture()
      assert :error == Authentication.valid?(@valid_email, "invlalid_password")
    end

    test "valid?/2 when given password and email are correct" do
      existing_user = user_fixture()
      assert {:ok, existing_user} == Authentication.valid?(@valid_email, @valid_password)
    end
  end
end
