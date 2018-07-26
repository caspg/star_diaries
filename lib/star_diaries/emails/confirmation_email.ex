defmodule StarDiaries.Emails.ConfirmationEmail do
  import Bamboo.Email

  @from_email Application.get_env(:star_diaries, :emails)[:from_email]

  def prepare(to_email, confirmation_url) do
    subject = "Confirmation email"
    body = """
    Welcome!

    Please confirm your account by clicking below link:

    #{confirmation_url}
    """

    new_email(
      to: to_email,
      from: @from_email,
      subject: subject,
      text_body: body
    )
  end
end
