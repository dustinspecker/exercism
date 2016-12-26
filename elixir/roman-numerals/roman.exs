defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(n) when n >= 1000, do: divide_and_convert(n, "M", 1000)
  def numerals(n) when n >= 900, do: divide_and_convert(n, "CM", 900)
  def numerals(n) when n >= 500, do: divide_and_convert(n, "D", 500)
  def numerals(n) when n >= 400, do: divide_and_convert(n, "CD", 400)
  def numerals(n) when n >= 100, do: divide_and_convert(n, "C", 100)
  def numerals(n) when n >= 90, do: divide_and_convert(n, "XC", 90)
  def numerals(n) when n >= 50, do: divide_and_convert(n, "L", 50)
  def numerals(n) when n >= 40, do: divide_and_convert(n, "XL", 40)
  def numerals(n) when n >= 10, do: divide_and_convert(n, "X", 10)
  def numerals(9), do: "IX"
  def numerals(n) when n >= 5, do: divide_and_convert(n, "V", 5)
  def numerals(4), do: "IV"
  def numerals(n), do: String.duplicate("I", n)
  
  defp divide_and_convert(n, roman, roman_value) do
    roman
    |> String.duplicate(div(n, roman_value))
    |> Kernel.<>(numerals(rem(n, roman_value)))
  end
end
