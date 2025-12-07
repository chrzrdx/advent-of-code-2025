defmodule AdventOfCode2025.Day07.Labs do
  @moduledoc """
  Utility functions for Day 07.
  """

  defstruct [:data]

  def from_file(filename) do
    [source_line | splitters_lines] =
      filename
      |> File.read!()
      |> String.split("\n", trim: true)

    source =
      source_line |> String.split("", trim: true) |> Enum.find_index(fn char -> char == "S" end)

    splitters =
      Enum.map(splitters_lines, fn line ->
        chars = String.split(line, "", trim: true) |> Enum.with_index()
        for {"^", index} <- chars, into: MapSet.new(), do: index
      end)
      |> Enum.reject(&Enum.empty?/1)

    %__MODULE__{data: {splitters, source}}
  end

  def solve_p1(%__MODULE__{data: {splitters, source}}) do
    count_splits(splitters, MapSet.new([source]), 0)
  end

  defp count_splits([], _beams, splits), do: splits

  defp count_splits(splitters, beams, splits) do
    [splitters_on_this_line | rest_splitters] = splitters

    hit_beams = MapSet.intersection(beams, splitters_on_this_line)
    unhit_beams = MapSet.difference(beams, splitters_on_this_line)

    new_beams =
      Enum.flat_map(hit_beams, fn s -> [s + 1, s - 1] end)
      |> MapSet.new()

    count_splits(
      rest_splitters,
      MapSet.union(new_beams, unhit_beams),
      splits + MapSet.size(hit_beams)
    )
  end

  def solve_p2(%__MODULE__{data: {splitters, source}}) do
    count_paths(splitters, %{source => 1})
  end

  defp count_paths([], beams_with_path_counts),
    do: beams_with_path_counts |> Map.values() |> Enum.sum()

  defp count_paths(splitters, beams_with_path_counts) do
    [splitters_on_this_line | rest_splitters] = splitters
    beams = Map.keys(beams_with_path_counts) |> MapSet.new()

    hit_beams = MapSet.intersection(beams, splitters_on_this_line)

    {hits, unhits} =
      Map.split(beams_with_path_counts, hit_beams |> MapSet.to_list())

    new_beams_with_path_counts =
      hits
      |> Enum.flat_map(fn {beam, count} -> [{beam + 1, count}, {beam - 1, count}] end)
      |> Enum.group_by(fn {beam, _} -> beam end, fn {_, count} -> count end)
      |> Map.new(fn {x, y} -> {x, Enum.sum(y)} end)
      |> Map.merge(unhits, fn _key, v1, v2 -> v1 + v2 end)

    count_paths(rest_splitters, new_beams_with_path_counts)
  end
end
