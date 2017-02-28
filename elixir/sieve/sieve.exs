defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    2..limit
    |> Enum.to_list()
    |> find_primes()
    |> Enum.reverse()
  end

  defp find_primes(numbers, primes \\ [])
  defp find_primes([], primes), do: primes
  defp find_primes([prime | remaining_numbers], primes) do
    remaining_numbers
    |> Enum.filter(&(rem(&1, prime) !== 0))
    |> find_primes([prime | primes])
  end
end
