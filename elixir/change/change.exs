defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns :error if it is not possible to compute the right amount of coins.
    Otherwise returns the tuple {:ok, map_of_coins}

    ## Examples

      iex> Change.generate(3, [5, 10, 15])
      :error

      iex> Change.generate(18, [1, 5, 10])
      {:ok, %{1 => 3, 5 => 1, 10 => 1}}

  """

  @spec generate(integer, list) :: {:ok, map} | :error
  def generate(amount, values) do
    sorted_values = Enum.sort(values, &(&1 > &2))

    _generate(amount, sorted_values, %{})
  end

  defp _generate(_, [], _), do: :error
  defp _generate(0, _, value_map), do: {:ok, value_map}
  defp _generate(amount, [h | t] = values, value_map) do
    if amount >= h && divisible?(amount - h, values) do
     _generate(amount - h, values, Map.update(value_map, h, 1, &(&1 + 1))) 
    else
      _generate(amount, t, Map.put_new(value_map, h, 0))
    end
  end

  defp divisible?(amount, values) do
    values
    |> Enum.any?(&(rem(amount, &1) === 0))
  end
end
