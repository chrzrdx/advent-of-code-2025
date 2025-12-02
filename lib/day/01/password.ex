defmodule AdventOfCode2025.Day01.Password do
  @moduledoc """
  Utility functions for Day 01.
  """

  defstruct [:data]

  @start_at 50
  @max_dial 100

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
      case String.split_at(line, 1) do
        {"R", rot} -> -String.to_integer(rot)
        {"L", rot} -> String.to_integer(rot)
      end
    end)
  end

  def solve_p1(%__MODULE__{data: rotations}) do
    Enum.reduce(
      rotations,
      [@start_at],
      fn rot, [top | rest] -> [Integer.mod(top + rot, @max_dial), top | rest] end
    )
    |> Enum.count(fn pos -> pos == 0 end)
  end

  def solve_p2(%__MODULE__{data: data}) do
    # TODO: Implement part 2
    data
  end
end
