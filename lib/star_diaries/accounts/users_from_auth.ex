defmodule StarDiaries.Accounts.UsersFromAuth do
  @moduledoc """
  The UsersFromAuth context.
  Handles lookup and creation of users and authorizations during social login.
  """

  alias StarDiaries.Accounts.AuthInfo
  alias StarDiaries.Accounts.Authorizations
  alias StarDiaries.Accounts
  alias StarDiaries.Repo

  def get_or_insert(%Ueberauth.Auth{} = auth) do
    require IEx; IEx.pry
    auth
    |> AuthInfo.to_struct
    |> get_or_insert
  end

  def get_or_insert(%AuthInfo{} = auth) do
    case get_authorization(auth) do
      nil -> sign_in_user_from_auth(auth)
      # TODO find user by authorization
    end
  end

  defp get_authorization(auth) do
    # TODO look by uid not token!
    Authorizations.get_by(provider: auth.provider, token: auth.credentials.token)
  end

  defp sign_in_user_from_auth(auth) do
    Repo.transaction fn ->
      user = get_user(auth) || create_user(auth)
      create_authorization(user, auth)
      user
    end
  end

  defp get_user(%{info: %{email: email}}) do
    Accounts.get_user_by(email: email)
  end

  defp create_user(%{info: %{email: email, name: name}}) do
    {:ok, user} = Accounts.create_user(email: email, name: name)
    user
  end

  defp create_authorization(user, %{provider: provider, credentials: %{token: token}}) do
    auth_attrs = %{provider: provider, token: token}
    {:ok, _} = Authorizations.create_with_user(user, auth_attrs)
  end
end
