defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(map, String.t, integer) :: map
  def add(db, name, grade) do
    db
    |> Map.update(grade, [name], &(add_name_to_sorted_list(&1, name)))
  end

  defp add_name_to_sorted_list(list, name) do
    list
    |> List.insert_at(-1, name)
    |> Enum.sort
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(map, integer) :: [String.t]
  def grade(db, grade) do
    db
    |> Map.get(grade, [])
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(map) :: [{integer, [String.t]}]
  def sort(db) do
    db
    |> Map.to_list
  end
end
