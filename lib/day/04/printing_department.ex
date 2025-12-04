defmodule AdventOfCode2025.Day04.PrintingDepartment do
  @moduledoc """
  Utility functions for Day 04.
  """

  defstruct [:papers]

  def from_file(filename) do
    papers =
      filename
      |> File.read!()
      |> String.split("\n", trim: true)
      |> parse_grid()

    %__MODULE__{papers: papers}
  end

  def solve_p1(%__MODULE__{papers: papers}) do
    papers |> find_removable() |> MapSet.size()
  end

  def solve_p2(%__MODULE__{papers: papers}) do
    MapSet.size(papers) - MapSet.size(remove_papers_recursively(papers))
  end

  # Parse grid into a MapSet of paper coordinates
  defp parse_grid(lines) do
    for {line, row} <- Enum.with_index(lines, 1),
        {char, col} <- Enum.with_index(String.graphemes(line), 1),
        char == "@",
        into: MapSet.new() do
      {row, col}
    end
  end

  # Find all papers that can be removed (< 4 neighbors)
  defp find_removable(papers) do
    papers
    |> Enum.filter(&removable?(&1, papers))
    |> MapSet.new()
  end

  # A paper is removable if it has fewer than 4 neighbors
  defp removable?(coord, papers) do
    coord
    |> neighbors()
    |> Enum.count(&MapSet.member?(papers, &1))
    |> Kernel.<(4)
  end

  # Get all 8 adjacent coordinates
  defp neighbors({row, col}) do
    for dx <- -1..1,
        dy <- -1..1,
        {dx, dy} != {0, 0} do
      {row + dx, col + dy}
    end
  end

  # Recursively remove papers until no more can be removed
  defp remove_papers_recursively(papers) do
    removable = find_removable(papers)

    if MapSet.size(removable) == 0 do
      papers
    else
      papers
      |> MapSet.difference(removable)
      |> remove_papers_recursively()
    end
  end
end
