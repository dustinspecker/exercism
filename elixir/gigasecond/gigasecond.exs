defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

  def from({{year, month, day}, {hours, minutes, seconds}}) do
    dt = %DateTime{year: year, month: month, day: day,
                   hour: hours, minute: minutes, second: seconds,
                   utc_offset: 0, std_offset: 0, time_zone: "America/Central", zone_abbr: "UTC"}

    dt
    |> DateTime.to_unix()
    |> Kernel.+(1_000_000_000)
    |> DateTime.from_unix()
    |> (fn({_, date}) ->
      {{date.year, date.month, date.day}, {date.hour, date.minute, date.second}}
    end).()
  end
end
