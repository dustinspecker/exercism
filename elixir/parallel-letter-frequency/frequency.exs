defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    pids = spawn_workers(self(), workers)
    
    result = 
      texts
      |> Stream.with_index()
      |> Enum.map(&get_letter_frequency(&1, pids))
      |> Enum.reduce(%{}, fn(current_map, all_map) ->
        Map.merge(all_map, current_map, fn(_, v1, v2) -> v1 + v2 end)
      end)

    stop_workers(pids)

    result
  end

  defp spawn_workers(parent, number) do
    1..number
    |> Enum.map(fn(_) ->
      spawn(fn -> letter_process(parent) end)
    end)
  end

  defp stop_workers(pids) do
    pids
      |> Enum.each(&send(&1, :stop))
  end

  defp get_letter_frequency({text, index}, pids) do
    pid = Enum.at(pids, rem(index, length(pids)))

    send(pid, {:count, text})

    receive do
      result ->
        result
    end
  end

  defp letter_process(parent) do
    receive do
      {:count, text} ->
        send(parent, letter_frequency(text))
        letter_process(parent)
      :stop ->
        exit(:normal)
    end
  end

  defp letter_frequency(text) do
    text
    |> String.downcase()
    |> String.trim()
    |> String.replace(~r/[0-9.,]/u, "")
    |> String.graphemes()
    |> Enum.reduce(%{}, fn(letter, map) ->
      Map.update(map, letter, 1, &(&1 + 1))
    end)
  end
end
