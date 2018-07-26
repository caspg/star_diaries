defmodule StarDiariesWeb.SessionController do
  use StarDiariesWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end
end
