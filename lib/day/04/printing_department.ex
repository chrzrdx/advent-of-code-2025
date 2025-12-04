defmodule AdventOfCode2025.Day04.PrintingDepartment do
  @moduledoc """
  Utility functions for Day 04.
  """

  defstruct [:grid]

  def from_file(filename) do
    grid =
      filename
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.with_index(1)
      |> Enum.flat_map(fn {line, row_index} ->
        line
        |> String.split("", trim: true)
        |> Enum.with_index(1)
        |> Enum.map(fn {char, col_index} -> {{row_index, col_index}, char} end)
      end)
      |> Enum.filter(fn {{_, _}, char} -> char == "@" end)
      |> Enum.into(%{})

    %__MODULE__{grid: grid}
  end

  def solve_p1(%__MODULE__{grid: grid}) do
    papers_to_remove(grid) |> Enum.count()
  end

  def solve_p2(%__MODULE__{grid: grid}) do
    grid_with_all_papers_removed = remove_papers_recursively(grid)
    remaining_papers = Enum.count(Map.keys(grid_with_all_papers_removed))
    initial_papers = Enum.count(Map.keys(grid))
    initial_papers - remaining_papers
  end

  defp papers_to_remove(grid) do
    Enum.filter(Map.keys(grid), fn coords -> can_remove?(coords, grid) end)
  end

  defp can_remove?(coords, grid) do
    Enum.count(adjacent_spaces(coords), fn {i, j} -> grid[{i, j}] == "@" end) < 4
  end

  defp adjacent_spaces({row, col}) do
    [
      {row - 1, col},
      {row + 1, col},
      {row, col - 1},
      {row, col + 1},
      {row - 1, col - 1},
      {row - 1, col + 1},
      {row + 1, col - 1},
      {row + 1, col + 1}
    ]
  end

  defp remove_papers(grid, papers_to_remove), do: Map.drop(grid, papers_to_remove)

  defp remove_papers_recursively(grid) do
    papers_to_remove = papers_to_remove(grid)

    if Enum.empty?(papers_to_remove) do
      grid
    else
      grid
      |> remove_papers(papers_to_remove)
      |> remove_papers_recursively()
    end
  end
end
