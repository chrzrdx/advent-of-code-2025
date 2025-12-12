defmodule AdventOfCode2025.Day09.MovieTheater do
  @moduledoc """
  Utility functions for Day 09.
  """

  defstruct [:data]

  def from_file(filename) do
    data =
      filename
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split(",", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)
      |> Enum.map(fn [x, y] -> {x, y} end)
      |> Enum.sort()

    %__MODULE__{data: data}
  end

  def solve_p1(%__MODULE__{data: data}) do
    # TODO: Implement part 1
    data
  end

  def solve_p2(%__MODULE__{data: data}) do
    # TODO: Implement part 2
    data
  end
end
