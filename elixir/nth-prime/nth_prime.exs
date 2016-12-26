defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0) do
    raise "invalid count"
  end
  def nth(count) do
    2
    |> Stream.iterate(&next_prime/1)
    |> Enum.take(count)
    |> List.last
  end

  @spec next_prime(pos_integer) :: pos_integer
  defp next_prime(current_number) do
    next_num = current_number + 1

    if get_factors(next_num) === [next_num] do
      next_num
    else
      next_prime(next_num)
    end
  end

  @spec get_factors(pos_integer) :: [pos_integer]
  defp get_factors(number) do
    Range.new(2, number)
      |> Enum.to_list
      |> Enum.filter(&(rem(number, &1) == 0))
  end
end
