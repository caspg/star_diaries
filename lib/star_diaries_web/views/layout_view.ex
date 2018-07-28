defmodule StarDiariesWeb.LayoutView do
  use StarDiariesWeb, :view

  def unconfirmed_user?(%{assigns: assigns} = _conn) do
    assigns[:user_signed_in?] && !assigns[:user_confirmed?]
  end

  def show_flash_message(conn, key) do
    conn
    |> get_flash(key)
    |> render_flash(key)
  end

  defp render_flash(nil, _), do: nil
  defp render_flash(msg, :info), do: render_flash_template(msg, :info)
  defp render_flash(msg, :error), do: render_flash_template(msg, :danger)
  defp render_flash(_, _), do: nil

  defp render_flash_template(message, flash_class) do
    Phoenix.View.render(
      StarDiariesWeb.LayoutView,
      "_flash_message.html",
      message: message,
      flash_class: flash_class
    )
  end
end
