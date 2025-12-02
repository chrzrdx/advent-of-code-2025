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
    |> Enum.flat_map(fn [a, b] ->
      Enum.filter(a..b, fn num ->
        str_num = Integer.to_string(num)
        num_digits = String.length(str_num)

        if rem(num_digits, 2) == 0 do
          repeated?(str_num, div(num_digits, 2))
        else
          false
        end
      end)
    end)
    |> Enum.sum()
  end

  def solve_p2(%__MODULE__{data: ranges}) do
    ranges
    |> Enum.flat_map(fn [a, b] ->
      Enum.filter(a..b, fn num ->
        str_num = Integer.to_string(num)
        repeated?(str_num)
      end)
    end)
    |> Enum.sum()
  end

  defp repeated?(str_num), do: repeated?(str_num, 1)

  defp repeated?(str_num, prefix_length) when 2 * prefix_length > byte_size(str_num), do: false

  defp repeated?(str_num, prefix_length) do
    {prefix, _} = String.split_at(str_num, prefix_length)

    if length(String.split(str_num, prefix, trim: true)) == 0 do
      true
    else
      repeated?(str_num, prefix_length + 1)
    end
  end
end
