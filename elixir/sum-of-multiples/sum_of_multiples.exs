defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(1, _) do
    0
  end
  def to(limit, factors) do
    Range.new(1, limit - 1)
    |> Enum.to_list
    |> Enum.filter(&(is_multiple_of(&1, factors)))
    |> Enum.reduce(0, &(&1 + &2))
  end

  defp is_multiple_of(num, numbers) do
    numbers
      |> Enum.any?(&(rem(num, &1) == 0))
  end
end
