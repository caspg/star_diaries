defmodule StarDiariesWeb.UsersController do
  use StarDiariesWeb, :controller

  alias StarDiariesWeb.UsersController

  plug(StarDiariesWeb.Plugs.EnsureUnLogged when action in [:new, :create])

  defdelegate create(conn, params), to: UsersController.Create, as: :call
  defdelegate new(conn, params), to: UsersController.New, as: :call
end
