defmodule StarDiaries.Helpers do
  def key_to_atom(map) do
    for {key, val} <- map, into: %{}, do: {convert_to_atom(key), val}
  end

  defp convert_to_atom(key) when is_atom(key), do: key
  defp convert_to_atom(key), do: String.to_atom(key)
end
