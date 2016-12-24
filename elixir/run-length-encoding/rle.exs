defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    string
      |> String.codepoints
      |> Enum.chunk_by(&(&1))
      |> Enum.map(fn(chunk) ->
        Integer.to_string(length(chunk)) <> List.first(chunk)
      end)
      |> Enum.join
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    string
      |> String.split(~r/\d+\w/, include_captures: true, trim: true)
      |> Enum.map(fn(chunk) ->
        String.split(chunk, ~r/\d+/, include_captures: true, trim: true)
      end)
      |> Enum.map(fn([times, letter]) ->
        String.duplicate(letter, String.to_integer(times))
      end)
      |> Enum.join
  end
end
