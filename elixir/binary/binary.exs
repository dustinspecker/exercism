defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    cond do
      only_binary_digits?(string) ->
        string
        |> String.graphemes()
        |> Enum.reverse()
        |> Enum.with_index()
        |> Enum.map(fn({binary, index}) ->
          String.to_integer(binary) * :math.pow(2, index)
        end)
        |> Enum.sum()
      true ->
        0
    end
  end

  defp only_binary_digits?(str) do
    !Regex.match?(~r/[^01]/, str)
  end
end
