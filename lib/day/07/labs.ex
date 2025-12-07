defmodule AdventOfCode2025.Day07.Labs do
  @moduledoc """
  Utility functions for Day 07.
  """

  defstruct [:splitters, :source]

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

    %__MODULE__{splitters: splitters, source: source}
  end

  @doc """
  Part 1: Count the number of times a beam is split by a splitter.
  """
  def count_splits(%__MODULE__{splitters: splitters, source: source}) do
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

  @doc """
  Part 2: Count the number of paths the source beam takes to exit the lab.
  """
  def count_paths(%__MODULE__{splitters: splitters, source: source}) do
    count_paths(splitters, %{source => 1})
  end

  defp count_paths([], beams_with_path_counts) do
    Enum.sum_by(beams_with_path_counts, fn {_beam, count} -> count end)
  end

  defp count_paths(splitters, beams_with_path_counts) do
    [splitters_on_this_line | rest_splitters] = splitters
    beams = Map.keys(beams_with_path_counts)

    splitters_hit =
      beams
      |> MapSet.new()
      |> MapSet.intersection(splitters_on_this_line)
      |> MapSet.to_list()

    {beams_split, beams_not_split} =
      Map.split(beams_with_path_counts, splitters_hit)

    new_beams_with_path_counts =
      beams_split
      |> Enum.reduce(
        beams_not_split,
        fn {beam, count}, acc ->
          acc
          |> Map.update(beam + 1, count, &(&1 + count))
          |> Map.update(beam - 1, count, &(&1 + count))
        end
      )

    count_paths(rest_splitters, new_beams_with_path_counts)
  end
end
