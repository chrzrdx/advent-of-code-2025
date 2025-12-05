defmodule AdventOfCode2025.Day05.Cafeteria do
  @moduledoc """
  Utility functions for Day 05.
  """

  defstruct [:ranges, :ingredients]

  def from_file(filename) do
    [ranges_str, ingredients_str] =
      filename
      |> File.read!()
      |> String.split("\n\n", trim: true)

    ranges =
      ranges_str
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split("-")
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)
      |> merge_ranges()

    ingredients =
      ingredients_str
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort()

    %__MODULE__{ranges: ranges, ingredients: ingredients}
  end

  defp merge_ranges(unmerged) do
    unmerged
    |> Enum.sort()
    |> then(fn [first | unmerged_rest] -> merge_ranges([first], unmerged_rest) end)
    |> Enum.map(fn {a, b} -> a..b end)
  end

  defp merge_ranges(merged, []), do: Enum.reverse(merged)

  defp merge_ranges([{a, b} | merged_rest], [{c, d} | unmerged_rest]) do
    cond do
      c > b -> merge_ranges([{c, d}, {a, b} | merged_rest], unmerged_rest)
      d <= b -> merge_ranges([{a, b} | merged_rest], unmerged_rest)
      true -> merge_ranges([{a, d} | merged_rest], unmerged_rest)
    end
  end

  def solve_p1(%__MODULE__{ranges: ranges, ingredients: ingredients}) do
    Enum.count(ingredients, fn ingredient ->
      Enum.any?(ranges, fn range -> ingredient in range end)
    end)
  end

  def solve_p2(%__MODULE__{ranges: ranges}) do
    Enum.sum_by(ranges, &Range.size/1)
  end
end
