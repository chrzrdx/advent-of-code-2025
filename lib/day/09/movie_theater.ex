defmodule AdventOfCode2025.Day09.MovieTheater do
  @moduledoc """
  Utility functions for Day 09.
  """

  defstruct [:points]

  def from_file(filename) do
    points =
      filename
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split(",", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)
      |> Enum.map(fn [x, y] -> {x, y} end)

    %__MODULE__{points: points}
  end

  def solve_p1(%__MODULE__{points: points}) do
    sorted_points = Enum.sort(points)

    for {x1, y1} <- sorted_points,
        {x2, y2} <- sorted_points,
        x1 < x2 do
      abs((x2 - x1 + 1) * (y2 - y1 + 1))
    end
    |> Enum.max()
  end

  def solve_p2(%__MODULE__{points: points}) do
    points
  end
end
