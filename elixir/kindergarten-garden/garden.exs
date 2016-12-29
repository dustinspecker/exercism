defmodule Garden do
  @letter_plant_map %{
    "C" => :clover,
    "G" => :grass,
    "R" => :radishes,
    "V" => :violets
  }
  @student_names [:alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet, :ileana,
                  :joseph, :kincaid, :larry]

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @student_names) do
    [first_row, second_row] = String.split(info_string, "\n")

    sorted_names = Enum.sort(student_names)

    populate_info(%{}, first_row, second_row, sorted_names) 
  end

  def populate_info(map, _, _, []) do
    map
  end
  def populate_info(map, first_row, second_row, [current_student_name | student_names]) do
    first_row_letters = String.slice(first_row, 0..1)
    second_row_letters = String.slice(second_row, 0..1)

    plants =
      first_row_letters <> second_row_letters
      |> String.graphemes
      |> Enum.map(&(@letter_plant_map[&1]))
      |> List.to_tuple

    new_map = Map.put(map, current_student_name, plants)
    next_first_row = String.slice(first_row, 2..-1)
    next_second_row = String.slice(second_row, 2..-1)

    populate_info(new_map, next_first_row, next_second_row, student_names)
  end
end
