defmodule StarDiariesWeb.Helpers.UserHelper do
  alias StarDiariesWeb.Endpoint
  alias StarDiariesWeb.Router.Helpers, as: Routes

  def generate_confirmation_url(%{confirmation_token: confirmation_token} = _user) do
    Routes.users_url(Endpoint, :confirm, t: confirmation_token)
  end
end
