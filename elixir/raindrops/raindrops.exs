defmodule Raindrops do
  @doc """
  Retrieve factors for a number
  """
  @spec get_factors(number) :: [pos_integer]
  def get_factors(number) do
    Range.new(1, number)
      |> Enum.to_list
      |> Enum.filter(&(rem(number, &1) == 0))
  end

  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    message = get_factors(number)
      |> Enum.map(fn(n) ->
        case n do
          3 ->
            "Pling"
          5 ->
            "Plang"
          7 ->
            "Plong"
          _ ->
            ""
        end
      end)
      |> Enum.join

    if message == "" do
      Integer.to_string(number)
    else
      message
    end
  end
end
