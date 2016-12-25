defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t) :: boolean
  def pangram?(sentence) do
    "abcdefghijklmnopqrstuvwxyz"
    |> String.split(~r/\w/, include_captures: true, trim: true)
    |> Enum.all?(&(word_contains_letter(sentence, &1)))
  end

  defp word_contains_letter(word, letter) do
    word
    |> String.downcase
    |> String.contains?(letter)
  end
end
