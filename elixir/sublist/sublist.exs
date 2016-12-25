defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a === b ->
        :equal
      contains?(a, b) ->
        :superlist
      contains?(b, a) ->
        :sublist
      true ->
        :unequal
    end
  end

  defp contains?(a, b) do
    b_count = Enum.count(b)

    cond do
      b_count > Enum.count(a) ->
        false
      Enum.take(a, b_count) === b ->
        true
      true ->
        [_ | t] = a
        contains?(t, b)
    end
  end
end
