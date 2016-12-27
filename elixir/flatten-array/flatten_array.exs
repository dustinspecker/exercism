defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """
  @spec flatten(list) :: list
  def flatten(l) do
    _flatten([], l)
    |> Enum.reverse
  end

  defp _flatten(flattened, []), do: flattened
  defp _flatten(flattened, [nil | tail]), do: _flatten(flattened, tail)
  defp _flatten(flattened, [head | tail]) when is_list(head) do
    new_flattened = _flatten(flattened, head)
    _flatten(new_flattened, tail)
  end
  defp _flatten(flattened, [head | tail]) do
    _flatten([head | flattened], tail)
  end
end
