defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    raw
    |> String.replace(~r/[^a-z0-9]/, "")
    |> clean_phone_number
  end

  defp clean_phone_number(phone_number) do
    len = String.length(phone_number)

    cond do
      !only_numbers?(phone_number) ->
        "0000000000"
      len === 10 ->
        phone_number
      len === 11 && String.at(phone_number, 0) === "1" ->
        phone_number
        |> String.slice(1..len)
      true ->
        "0000000000"
    end
  end

  defp only_numbers?(phone_number) do
    phone_number
    |> (&Regex.scan(~r/[0-9]/, &1)).()
    |> (&Enum.count(&1) === String.length(phone_number)).()
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    start_index = if String.length(raw) === 10, do: 0, else: 1

    raw
    |> String.slice(start_index, 3)
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    start_index = if String.length(raw) === 10, do: 0, else: 1

    "("
    |> Kernel.<>(String.slice(raw, start_index, 3))
    |> Kernel.<>(") ")
    |> Kernel.<>(String.slice(raw, start_index + 3, 3))
    |> Kernel.<>("-")
    |> Kernel.<>(String.slice(raw, start_index + 6, 4))
  end
end
