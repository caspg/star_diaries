defmodule StarDiaries.Accounts.UsersFromAuth do
  @moduledoc """
  The UsersFromAuth context.
  Handles lookup and creation of users and identities during social login.
  """

  alias StarDiaries.Repo
  alias StarDiaries.Accounts.AuthInfo
  alias StarDiaries.Accounts.Identities
  alias StarDiaries.Accounts.Users
  alias StarDiaries.Accounts.User

  def get_or_insert(%Ueberauth.Auth{} = auth) do
    auth
    |> AuthInfo.to_struct()
    |> get_or_insert
  end

  def get_or_insert(%AuthInfo{} = auth) do
    case get_identity(auth) do
      nil ->
        sign_in_user_from_auth(auth)

      identity ->
        get_user_from_identity(identity)
    end
  end

  defp get_identity(auth) do
    Identities.get_by(uid: auth.uid, provider: auth.provider)
  end

  defp sign_in_user_from_auth(auth) do
    Repo.transaction(fn ->
      {:ok, user} = get_or_create_user(auth)
      {:ok, _} = create_identity(user, auth)
      user
    end)
  end

  defp get_or_create_user(%{info: %{email: email, name: name}}) do
    case Users.get_user_by(email: email) do
      nil ->
        Users.create_user_from_identity(%{email: email, name: name})

      user ->
        {:ok, user}
    end
  end

  defp create_identity(user, auth) do
    Identities.create_with_user(user, %{
      provider: auth.provider,
      token: auth.credentials.token,
      uid: auth.uid,
      nickname: auth.info.nickname
    })
  end

  defp get_user_from_identity(identity) do
    user = Identities.get_user(identity)
    {:ok, user}
  end
end
