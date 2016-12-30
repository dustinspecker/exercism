defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(white \\ {0, 3}, black \\ {7, 3})
  def new(white, white) do
    raise ArgumentError
  end
  def new(white, black)  do
    %{white: white, black: black}
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    0..7
    |> Enum.map(fn(y) ->
      0..7
      |> Enum.map(fn(x) ->
        get_board_character(x, y, queens.white, queens.black)
      end)
      |> Enum.join()
    end)
    |> Enum.join("\n")

  end

  defp get_board_character(x, y, white, black) do
    {white_y, white_x} = white
    {black_y, black_x} = black

    first_char =
      cond do
        x === white_x && y === white_y ->
          "W"
        x === black_x && y === black_y ->
          "B"
        true ->
          "_"
      end

    second_char = if x === 7, do: "", else: " "

    first_char <> second_char
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
    {white_y, white_x} = queens.white
    {black_y, black_x} = queens.black

    white_x === black_x || black_y === white_y ||
    abs(white_y - black_y) === abs(white_x - black_x)
  end
end
