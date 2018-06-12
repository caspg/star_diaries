defmodule StarDiariesWeb.UsersController do
  use StarDiariesWeb, :controller

  def new(conn, _params) do
    render(conn, "join.html")
  end

  def create(conn, _params) do
  end
end
