defmodule AdventOfCode2025.Day06.TrashCompactor do
  @moduledoc """
  Utility functions for Day 06.
  """

  defstruct [:data]

  def from_file(filename) do
    lines =
      filename
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, " ", trim: true))

    {numbers_lines, [ops]} = Enum.split(lines, -1)

    nums = Enum.zip(numbers_lines)

    %__MODULE__{data: Enum.zip(nums, ops)}
  end

  def solve_p1(%__MODULE__{data: data}) do
    Enum.sum_by(
      data,
      fn
        {nums, "*"} -> nums |> Tuple.to_list() |> Enum.product_by(&String.to_integer/1)
        {nums, "+"} -> nums |> Tuple.to_list() |> Enum.sum_by(&String.to_integer/1)
      end
    )
  end

  def solve_p2(%__MODULE__{data: data}) do
    # TODO: Implement part 2
    data
  end
end
