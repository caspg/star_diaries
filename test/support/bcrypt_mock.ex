defmodule StarDiariesWeb.BcryptMock do
  @moduledoc """
  A mock module to encrypt password in test environment.
  """

  def hashpwsalt(raw), do: Base.encode64(raw)

  def checkpw(password, encrypted_password) do
    Base.encode64(password) == encrypted_password
  end

  def dummy_checkpw, do: nil
end
