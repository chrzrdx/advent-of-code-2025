defmodule AdventOfCode2025.Day12.Farm do
  @moduledoc """
  Utility functions for Day 12.
  """

  defstruct [:data]

  def from_file(filename) do
    data =
      filename
      |> File.read!()
      |> String.split("\n", trim: true)
      |> parse_lines()

    %__MODULE__{data: data}
  end

  defp parse_lines(lines) do
    Enum.map(lines, fn line ->
      String.split(line, " ", trim: true)
    end)
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
