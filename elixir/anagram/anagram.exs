defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    candidates
    |> Enum.filter(&anagram?(&1, base))
  end

  defp anagram?(a, b) do
    lower_a = String.downcase(a)
    lower_b = String.downcase(b)

    lower_a !== lower_b && sort_letters(lower_a) === sort_letters(lower_b)
  end

  defp sort_letters(word) do
    word
    |> String.graphemes
    |> Enum.sort(&(&1 <= &2))
    |> Enum.join
  end
end
