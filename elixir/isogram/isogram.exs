defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    formatted = get_formatted(sentence)

    formatted
    |> (&Regex.scan(~r/\w/u, &1)).()
    |> Enum.uniq
    |> Enum.count
    |> (&(&1 === String.length(formatted))).()
  end

  defp get_formatted(str) do
    str
    |> String.downcase
    |> String.replace(~r/\W/u, "")
  end
end
