defmodule Bob do
  def hey(input) do
    cond do
      String.trim(input) == "" ->
        "Fine. Be that way!"
      String.last(input) == "?" ->
        "Sure."
      input == String.upcase(input) && String.downcase(input) != String.upcase(input) ->
        "Whoa, chill out!"
      true ->
        "Whatever."
    end
  end
end
