defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
      |> String.downcase
      |> String.replace("_", " ")
      |> String.replace(~r/[^\w -]/u, "")
      |> String.split
      |> Enum.reduce(%{}, fn(word, wordMap) ->
        Map.update(wordMap, word, 1, &(&1 + 1))
      end)
  end
end
