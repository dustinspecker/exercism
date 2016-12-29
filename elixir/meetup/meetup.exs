defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @day_of_week_to_weekday_map %{
    :monday => 1,
    :tuesday => 2,
    :wednesday => 3,
    :thursday => 4,
    :friday => 5,
    :saturday => 6,
    :sunday => 7
  }

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
     
    {year, month, get_desired_day(year, month, weekday, schedule)}
  end

  defp get_desired_day(year, month, weekday, schedule) do
    date_range = get_date_range(schedule, year, month)

    date_range
    |> Enum.to_list
    |> Enum.map(fn(day) ->
      {_, date} = Date.new(year, month, day)

      date
    end)
    |> Enum.find(&date_is_on_weekday(&1, weekday))
    |> (fn(date) -> date.day end).()
  end

  defp date_is_on_weekday(date, weekday) do
    :calendar.day_of_the_week(Date.to_erl(date)) === @day_of_week_to_weekday_map[weekday]
  end

  defp get_date_range(:first, _, _), do: 1..7
  defp get_date_range(:second, _, _), do: 8..14
  defp get_date_range(:third, _, _), do: 15..21
  defp get_date_range(:fourth, _, _), do: 22..28
  defp get_date_range(:teenth, _, _), do: 13..19
  defp get_date_range(:last, year, month) do
    last_day_of_month = :calendar.last_day_of_the_month(year, month)

    Range.new(last_day_of_month - 6, last_day_of_month)
  end
end
