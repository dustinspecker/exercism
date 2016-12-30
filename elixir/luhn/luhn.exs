defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    number
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.reverse()
    |> Enum.with_index(1)
    |> Enum.map(fn({number, index}) ->
      if rem(index, 2) === 0 do
        new_number = number * 2
        if (new_number > 10) do
          new_number - 9
        else
          new_number
        end
      else
        number
      end
    end)
    |> Enum.sum()
  end

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    number
    |> checksum
    |> Integer.to_string()
    |> String.graphemes()
    |> List.last()
    |> (&(&1 === "0")).()
  end

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def create(number) do
    0..9
    |> Stream.map(&Integer.to_string/1)
    |> Stream.map(&(number <> &1))
    |> Enum.find(&valid?/1)
  end
end
