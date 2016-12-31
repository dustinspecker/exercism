defmodule Matrix do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
    |> String.split("\n")
    |> Enum.map(fn(row) ->
      row
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
    end)

  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str
    |> rows()
    |> transpose()
  end

  @spec transpose([[any]]) :: [[any]]
  defp transpose(matrix) do
      matrix
      |> List.zip()
      |> Enum.map(&Tuple.to_list/1)
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    rows = rows(str)
    cols = columns(str)

    rows
    |> length()
    |> make_grid()
    |> Enum.filter(fn({i, j}) ->
      max_in_row =
        rows
        |> Enum.at(i)
        |> Enum.max()

      min_in_col =
        cols
        |> Enum.at(j)
        |> Enum.min()

      cell_value =
        rows
        |> Enum.at(i)
        |> Enum.at(j)

      cell_value === max_in_row && cell_value === min_in_col
    end)
  end

  defp make_grid(size) do
    range = 0..(size - 1)
    for i <- range, j <- range, do: {i, j}
  end
end
