defmodule StarDiaries.EmailsTest do
  use StarDiaries.DataCase
  use Bamboo.Test

  alias StarDiaries.Emails

  test "send_confirmation_email/2" do
    to_email = "some@email.com"
    confirmation_url = "todo.todo"

    email = Emails.send_confirmation_email(to_email, confirmation_url)

    assert_delivered_email email
    assert email.to == [nil: to_email]
    assert email.from == {nil, Application.get_env(:star_diaries, :emails)[:from_email]}
    assert email.text_body =~ confirmation_url
  end
end
