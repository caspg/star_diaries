defmodule StarDiariesWeb.Plugs.SetCurrentUser do
  import Plug.Conn

  alias StarDiaries.Accounts

  def init(_options) do
  end

  def call(conn, _options) do
    current_user_id = get_user_id(conn)
    maybe_find_user(conn, current_user_id)
  end

  defp maybe_find_user(conn, nil), do: assign_unlogged_user(conn)

  defp maybe_find_user(conn, current_user_id) do
    case Accounts.get_user(current_user_id) do
      user ->
        assign_logged_in_user(conn, user)
      nil ->
        assign_unlogged_user(conn)
    end
  end

  defp get_user_id(conn) do
    Plug.Conn.get_session(conn, :current_user_id)
  end

  defp assign_logged_in_user(conn, user) do
    conn
    |> assign(:current_user, user)
    |> assign(:user_signed_in?, true)
  end

  defp assign_unlogged_user(conn) do
    conn
    |> assign(:current_user, nil)
    |> assign(:user_signed_in?, false)
  end
end
