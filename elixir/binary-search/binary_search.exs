defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _), do: :not_found
  def search(numbers, key) do
    _search(numbers, key, 0, tuple_size(numbers) - 1)
  end

  defp _search(numbers, key, starting_index, ending_index) when ending_index - starting_index === 1 do
    middle_index = (ending_index + starting_index) / 2

    left_index = round(Float.floor(middle_index))
    left_value = elem(numbers, left_index)
    right_index = round(Float.ceil(middle_index))
    right_value = elem(numbers, right_index)

    cond do
      left_value === key ->
        {:ok, left_index}
      right_value === key ->
        {:ok, right_index}
      true ->
        :not_found
    end
  end
  defp _search(numbers, key, starting_index, ending_index) do
    middle_index = div(ending_index + starting_index, 2)
    middle_value = elem(numbers, middle_index)

    cond do
      middle_value === key ->
        {:ok, middle_index}
      middle_value < key ->
        _search(numbers, key, middle_index, ending_index)
      middle_value > key ->
        _search(numbers, key, starting_index, middle_index)
      true ->
        :not_found
    end
  end
end
