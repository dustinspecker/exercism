defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    rows(num - 1, [[1]])
  end

  defp rows(0, rows), do: Enum.reverse(rows)
  defp rows(num, [h | _] = rows) do
    rows(num - 1, [next_row(h) | rows])
  end

  defp next_row(row) do
    row
    |> Enum.flat_map(&[&1, &1])
    |> Enum.slice(1..-2)
    |> Enum.chunk(2)
    |> Enum.map(fn([a, b]) -> a + b end)
    |> (&([1] ++ &1 ++ [1])).()
  end
end
