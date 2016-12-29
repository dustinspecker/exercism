defmodule BracketPush do
  @openings ["(", "{", "["]
  @closings [")", "}", "]"]
  @pair_map %{
    "(" => ")",
    "{" => "}",
    "[" => "]"
  }

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    str
    |> String.graphemes
    |> Enum.reduce({:ok, []}, &(parse(&1, &2)))
    |> is_valid_result
  end

  defp parse(_, {:error, stack}) do
    {:error, stack}
  end
  defp parse(char, {status, stack}) do
    cond do
      !Enum.member?(@openings ++ @closings, char) ->
        {status, stack}
      Enum.member?(@openings, char) ->
        {:ok, List.insert_at(stack, -1, char)}
      Enum.member?(@closings, char) ->
        {last_char, new_stack} = list_pop(stack)
        if pair_matches(last_char, char) do
          {:ok, new_stack}
        else 
          {:error, stack}
        end
    end
  end

  defp is_valid_result({status, stack}) do
    status === :ok && stack === [] 
  end

  defp pair_matches(last_char, next_char) do
    @pair_map[last_char] === next_char
  end

  defp list_pop(list) do
    {List.last(list), Enum.drop(list, -1)}
  end
end
