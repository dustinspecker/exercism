defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Map.to_list()
    |> Enum.reduce(%{}, fn({value, words}, map) ->
      word_map = convert_word_list_to_map(words, value)

      Map.merge(map, word_map)
    end)
  end

  defp convert_word_list_to_map(word_list, value) do
    word_list
    |> Enum.map(&(String.downcase(&1)))
    |> Enum.reduce(%{}, fn(word, map) ->
      Map.put(map, word, value)
    end)
  end
end
