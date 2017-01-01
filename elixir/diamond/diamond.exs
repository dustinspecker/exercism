defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t
  def build_shape(letter) do
    number_of_columns = (letter - ?A) * 2 + 1

    get_letters_up_to_and_including_middle(letter) ++ get_letters_after_middle(letter)
    |> Enum.map_join(&get_row(&1, number_of_columns))
  end

  defp get_letters_up_to_and_including_middle(letter) do
    ?A..letter
    |> Enum.to_list()
  end

  defp get_letters_after_middle(?A), do: []
  defp get_letters_after_middle(letter) do
    (letter - 1)..?A
    |> Enum.to_list()
  end

  defp get_row(?A, length) do
    length
    |> Kernel./(2)
    |> Float.floor()
    |> round()
    |> get_space_string()
    |> (&(&1 <> "A" <> &1 <> "\n")).()
  end
  defp get_row(letter, length) do
    middle_buffer =
    (letter - ?A - 1) * 2 + 1
    |> get_space_string()

    letter_string = to_string([letter])

    (length - String.length(middle_buffer) - 2) / 2
    |> Float.floor()
    |> round()
    |> get_space_string()
    |> (&(&1 <> letter_string <> middle_buffer <> letter_string <> &1 <> "\n")).()
  end

  defp get_space_string(0), do: ""
  defp get_space_string(count) do
    1..count
    |> Enum.map(fn(_) -> " " end)
    |> Enum.join()
  end
end
