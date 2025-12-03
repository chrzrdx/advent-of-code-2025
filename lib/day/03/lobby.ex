defmodule AdventOfCode2025.Day03.Lobby do
  @moduledoc """
  Utility functions for Day 03.
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
      line |> String.split("", trim: true) |> Enum.map(&String.to_integer/1)
    end)
  end

  def solve_p1(%__MODULE__{data: banks}) do
    Enum.sum_by(banks, &get_max_joltage_with_two_batteries/1)
  end

  def solve_p2(%__MODULE__{data: banks}) do
    Enum.sum_by(banks, &get_max_joltage_with_twelve_batteries/1)
  end

  defp get_max_joltage_with_two_batteries(bank) do
    [a, b | batteries] = bank

    Enum.reduce(
      batteries,
      {a, b},
      fn c, {x, y} -> Enum.max([{x, y}, {x, c}, {y, c}]) end
    )
    |> Tuple.to_list()
    |> Enum.join()
    |> String.to_integer()
  end

  defp get_max_joltage_with_twelve_batteries(bank) do
    [a, b, c, d, e, f, g, h, i, j, k, l | batteries] = bank

    Enum.reduce(
      batteries,
      {a, b, c, d, e, f, g, h, i, j, k, l},
      fn c, max_twelve ->
        Enum.max(
          Enum.map(
            0..11,
            fn i -> max_twelve |> Tuple.delete_at(i) |> Tuple.insert_at(11, c) end
          ) ++
            [max_twelve]
        )
      end
    )
    |> Tuple.to_list()
    |> Enum.join()
    |> String.to_integer()
  end
end
