defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count([]) do 0 end
  def count([_ | tail]) do
    1 + count(tail)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    _reverse(l, [])
  end

  defp _reverse([], reversed) do reversed end
  defp _reverse([head | tail], reversed) do
    _reverse(tail, [head|reversed])
  end

  @spec map(list, (any -> any)) :: list
  def map([], _) do [] end
  def map([head | tail], f) do
    [f.(head) | map(tail, f)]
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _) do [] end
  def filter([head | tail], f) do
    if f.(head) do
      [head | filter(tail, f)]
    else
      filter(tail, f)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _) do acc end
  def reduce([head | tail], acc, f) do
    reduce(tail, f.(head, acc), f)
  end

  @spec append(list, list) :: list
  def append([], []) do [] end
  def append([], list) do list end
  def append(list, []) do list end
  def append([head | tail], b) do
    [head | append(tail, b)]
  end

  @spec concat([[any]]) :: [any]
  def concat([]) do [] end
  def concat([[] | tail]) do concat(tail) end
  def concat([[sub_head | sub_tail] | tail]) do
    [sub_head | concat([sub_tail | tail])] 
  end
end
