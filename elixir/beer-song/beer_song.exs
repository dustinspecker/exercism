defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t
  def verse(1) do
    """
    No more bottles of beer on the wall, no more bottles of beer.
    Go to the store and buy some more, 99 bottles of beer on the wall.
    """
  end
  def verse(number) do
    next_bottle_phrase = if number > 2, do: number - 2, else: "no more"
    bottle = if number - 1 === 1, do: "bottle", else: "bottles"
    bottle2 = if number - 2 === 1, do: "bottle", else: "bottles"
    take = if number - 1 === 1, do: "it", else: "one"
    """
    #{number - 1} #{bottle} of beer on the wall, #{number - 1} #{bottle} of beer.
    Take #{take} down and pass it around, #{next_bottle_phrase} #{bottle2} of beer on the wall.
    """
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t) :: String.t
  def lyrics do
    lyrics(100..1)
  end
  def lyrics(range) do
    range
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end
end
