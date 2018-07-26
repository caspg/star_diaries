defmodule StarDiaries.Emails do
  alias StarDiaries.Emails.ConfirmationEmail
  alias StarDiaries.Emails.Mailer

  def send_confirmation_email(to_email, confirmation_url) do
    ConfirmationEmail.prepare(to_email, confirmation_url)
    |> Mailer.deliver_later()
  end
end
