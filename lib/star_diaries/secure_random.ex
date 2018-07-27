defmodule StarDiaries.SecureRandom do
  @moduledoc """
  Module for generating url-safe random tokens.
  """

  def generate(length \\ 64) do
    length
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64
    |> binary_part(0, length)
  end
end
