defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    cond do
      only_hex_characters?(hex) ->
        hex
        |> String.downcase()
        |> String.graphemes()
        |> Enum.reverse()
        |> Enum.with_index()
        |> Enum.map(fn({hex, power}) ->
          get_integer_value(hex) * :math.pow(16, power)
        end)
        |> Enum.sum()
      true ->
        0
    end
  end

  @spec only_hex_characters?(String.t()) :: Boolean
  defp only_hex_characters?(hex) do
    !Regex.match?(~r/[^a-fA-f0-9]/, hex)
  end

  @spec get_integer_value(String.t()) :: integer
  defp get_integer_value("a"), do: 10
  defp get_integer_value("b"), do: 11
  defp get_integer_value("c"), do: 12
  defp get_integer_value("d"), do: 13
  defp get_integer_value("e"), do: 14
  defp get_integer_value("f"), do: 15
  defp get_integer_value(hex), do: String.to_integer(hex)
end
