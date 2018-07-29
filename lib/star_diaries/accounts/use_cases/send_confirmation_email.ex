defmodule StarDiaries.Accounts.UseCases.SendConfirmationEmail do
  alias StarDiaries.Emails
  alias StarDiaries.Accounts

  def call(%{email: email} = user, confirmation_url) do
    Emails.send_confirmation_email(email, confirmation_url)

    Accounts.update_user(user, %{
      confirmation_sent_at: NaiveDateTime.utc_now()
    })
  end
end
