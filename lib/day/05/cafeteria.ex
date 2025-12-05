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
        [a, b] = String.split(line, "-", trim: true) |> Enum.map(&String.to_integer/1)
        a..b
      end)

    ingredients =
      ingredients_str
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)

    %__MODULE__{ranges: ranges, ingredients: ingredients}
  end

  def solve_p1(%__MODULE__{ranges: ranges, ingredients: ingredients}) do
    Enum.count(ingredients, fn ingredient ->
      Enum.any?(ranges, fn range -> ingredient in range end)
    end)
  end

  def solve_p2(%__MODULE__{}) do
    0
  end
end
