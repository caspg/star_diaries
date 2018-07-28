defmodule StarDiariesWeb.UsersController do
  use StarDiariesWeb, :controller

  alias StarDiariesWeb.UsersController

  plug(StarDiariesWeb.Plugs.EnsureUnLogged when action in [:new, :create])
  plug(StarDiariesWeb.Plugs.EnsureLoggedIn when action in [:confirm])

  defdelegate new(conn, params), to: UsersController.New, as: :call
  defdelegate create(conn, params), to: UsersController.Create, as: :call
  defdelegate confirm(conn, params), to: UsersController.Confirm, as: :call
end
