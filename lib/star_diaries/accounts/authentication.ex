defmodule StarDiaries.Accounts.Authentication do
  alias StarDiaries.Accounts.Users

  @bcrypt Application.get_env(:star_diaries, :bcrypt)

  def valid?(nil, _password), do: :error
  def valid?(_email, nil), do: :error

  def valid?(email, password) do
    user = Users.get_user_by(%{email: email})

    case user do
      nil ->
        invalid_password()

      user ->
        valid_password?(user, password)
    end
  end

  defp invalid_password do
    # Run a dummy check, which always returns false, to make user enumeration more difficult
    @bcrypt.dummy_checkpw()
    :error
  end

  defp valid_password?(user, password) do
    if @bcrypt.checkpw(password, user.encrypted_password) do
      {:ok, user}
    else
      :error
    end
  end
end
