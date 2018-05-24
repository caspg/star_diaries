defmodule StarDiariesWeb.AuthController do
  @moduledoc """
  Handles the Überauth authentication.
  """

  alias StarDiariesWeb.AuthController.Logout
  alias StarDiariesWeb.AuthController.Callback

  use StarDiariesWeb, :controller

  plug(Ueberauth)

  def callback(conn, _params), do: Callback.call(conn)

  def logout(conn, _params), do: Logout.call(conn)
end
