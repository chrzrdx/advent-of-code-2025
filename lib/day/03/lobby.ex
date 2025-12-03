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
      line
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  def solve_p1(%__MODULE__{data: banks}) do
    Enum.sum_by(banks, fn bank -> get_max_joltage_with_n_batteries(bank, 2) end)
  end

  def solve_p2(%__MODULE__{data: banks}) do
    Enum.sum_by(banks, fn bank -> get_max_joltage_with_n_batteries(bank, 12) end)
  end

  defp get_max_joltage_with_n_batteries(bank, n) do
    {initial_max_n, rest} = Enum.split(bank, n)

    Enum.reduce(
      rest,
      initial_max_n,
      fn c, max_n -> drop_one_digit(max_n ++ [c]) end
    )
    |> Enum.join()
    |> String.to_integer()
  end

  # Find first digit smaller than next, drop it
  # If none found (descending order), drop the last digit
  defp drop_one_digit([a, b | rest]) when a < b, do: [b | rest]
  defp drop_one_digit([a, b | rest]), do: [a | drop_one_digit([b | rest])]
  defp drop_one_digit([_last]), do: []
end
