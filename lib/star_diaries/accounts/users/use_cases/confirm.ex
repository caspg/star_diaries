defmodule StarDiaries.Accounts.Users.UseCases.Confirm do
  alias StarDiaries.Accounts.Users

  def call(token) do
    with {:ok, user} <- get_user_by_confirmation_token(token),
         {:ok, user} <- confirm_user(user)
    do
      {:ok, user}
    else
      {:error, error} ->
        {:error, error}

      _ ->
        :error
    end
  end

  defp get_user_by_confirmation_token(token) do
    case Users.get_by(%{confirmation_token: token}) do
      nil ->
        {:error, :invalid_token}
      user ->
        {:ok, user}
    end
  end

  defp confirm_user(%{confirmed_at: nil} = user) do
    confirmed_at = NaiveDateTime.utc_now()

    case Users.confirm(user, confirmed_at) do
      {:ok, user} ->
        {:ok, user}

      _ ->
        :error
    end
  end

  defp confirm_user(_user), do: {:error, :user_already_confirmed}
end
