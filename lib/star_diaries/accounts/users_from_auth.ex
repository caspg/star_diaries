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
    auth |> AuthInfo.to_struct |> get_or_insert
  end

  def get_or_insert(%AuthInfo{} = auth) do
    case get_authorization(auth) do
      nil -> register_user_from_auth(auth)
    end
  end

  defp get_authorization(auth) do
    Authorizations.get_by(provider: auth.provider, token: auth.credentials.token)
  end

  defp register_user_from_auth(auth) do
    {:ok, user} = create_user_and_authorization(auth)
  end

  defp create_user_and_authorization(auth) do
    %{
      provider: provider,
      credentials: %{token: token},
      info: %{email: email, name: name}
    } = auth

    Repo.transaction fn ->
      {:ok, user} = Accounts.create_user(%{email: email, name: name})
      {:ok, _} = Authorizations.create_with_user(user, %{provider: provider, token: token})
      user
    end
  end
end
