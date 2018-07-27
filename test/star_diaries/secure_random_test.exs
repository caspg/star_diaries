defmodule StarDiaries.SecureRandomTest do
  use StarDiaries.DataCase

  alias StarDiaries.SecureRandom

  test "generate/0" do
    assert SecureRandom.generate() |> String.length == 64
  end

  test "generate/1" do
    length = 32
    assert SecureRandom.generate(length) |> String.length == length
  end
end
