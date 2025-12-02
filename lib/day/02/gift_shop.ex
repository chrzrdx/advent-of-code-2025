defmodule AdventOfCode2025.Day02.GiftShop do
  @moduledoc """
  Utility functions for Day 02.
  """

  defstruct [:data]

  def from_file(filename) do
    data =
      filename
      |> File.read!()
      |> String.trim("\n")
      |> String.split(",")
      |> Enum.map(fn range ->
        range
        |> String.split("-", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)

    %__MODULE__{data: data}
  end

  def solve_p1(%__MODULE__{data: ranges}) do
    ranges
    |> Enum.flat_map(&find_invalid_ids_in_range/1)
    |> Enum.sum()
  end

  def solve_p2(%__MODULE__{data: data}) do
    # TODO: Implement part 2
    data
  end

  defp find_invalid_ids_in_range([a, b]) do
    Enum.filter(a..b, fn num ->
      str_num = Integer.to_string(num)
      num_digits = String.length(str_num)
      invalid?(str_num, num_digits)
    end)
  end

  defp invalid?(str_num, num_digits) when rem(num_digits, 2) == 0 do
    {a, b} = String.split_at(str_num, div(num_digits, 2))
    a == b
  end

  defp invalid?(_str_num, num_digits) when rem(num_digits, 2) == 1, do: false
end
