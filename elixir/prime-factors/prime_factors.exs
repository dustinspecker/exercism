defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    _factors_for(number, 2, [])
  end

  defp _factors_for(number, current_factor, prime_factors) when number < current_factor do
    prime_factors
  end
  defp _factors_for(number, current_factor, prime_factors) when rem(number, current_factor) === 0 do
    [current_factor | _factors_for(div(number, current_factor), current_factor, prime_factors)]
  end
  defp _factors_for(number, current_factor, prime_factors) do
    _factors_for(number, current_factor + 1, prime_factors)
  end
end
