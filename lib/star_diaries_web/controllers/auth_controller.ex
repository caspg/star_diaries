defmodule StarDiariesWeb.AuthController do
  @moduledoc """
  Handles the Überauth authentication.
  """

  use StarDiariesWeb, :controller

  plug Ueberauth

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%Plug.Conn{assigns: %{ueberauth_auth: auth}} = conn, params) do
    require IEx
    IEx.pry
  end
end
