defmodule StarDiariesWeb.Plugs.SetCurrentUserTest do
  use StarDiariesWeb.ConnCase

  alias StarDiaries.Accounts

  test "nil values are assigned when there is no current_user_id" do
    conn = run_plug(nil)

    assert conn.assigns[:current_user] == nil
    assert conn.assigns[:user_signed_in?] == false
    assert conn.assigns[:user_confirmed?] == false
  end

  test "nil values are assigned when user is not found" do
    conn = run_plug(101)

    assert conn.assigns[:current_user] == nil
    assert conn.assigns[:user_signed_in?] == false
    assert conn.assigns[:user_confirmed?] == false
  end

  test "current_user is assigned" do
    {:ok, user} = Accounts.create_user(%{
      email: "email@email.com",
      name: "name",
      password: "Password1",
      password_confirmation: "Password1",
      confirmed_at: NaiveDateTime.utc_now()
    })
    conn = run_plug(user.id)

    assert conn.assigns[:current_user] == user
    assert conn.assigns[:user_signed_in?] == true
    assert conn.assigns[:user_confirmed?] == true
  end

  defp run_plug(current_user_id) do
    build_conn()
    |> Plug.Test.init_test_session(foo: "bar")
    |> put_session(:current_user_id, current_user_id)
    |> StarDiariesWeb.Plugs.SetCurrentUser.call(%{})
  end
end
