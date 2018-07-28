defmodule StarDiariesWeb.UsersController.Confirm do
  import Phoenix.Controller

  alias StarDiaries.Accounts

  def call(conn, %{"t" => token}) do
    {flash_status, message} = perform_confirmation(token)

    conn
    |> put_flash(flash_status, message)
    |> redirect(to: "/")
  end

  def call(conn, _params) do
    conn
    |> put_flash(:error, "Confirmation token is invalid!")
    |> redirect(to: "/")
  end

  defp perform_confirmation(token) do
    case Accounts.confirm_user(token) do
      {:ok, user} ->
        {:info, "Your account was successfully confirmed."}

      {:error, :invalid_token} ->
        {:error, "Confirmation token is invalid!"}

      {:error, :user_already_confirmed} ->
        {:warning, "Your account has already been confirmed."}

      :error ->
        {:error, "Something went wrong during confirmation. Please try again later."}
    end
  end
end
