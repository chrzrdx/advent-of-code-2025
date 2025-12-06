defmodule AdventOfCode2025.Day06.TrashCompactor do
  @moduledoc """
  Utility functions for Day 06.
  """

  defstruct [:data]

  def from_file_p1(filename) do
    lines =
      filename
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, " ", trim: true))

    {numbers_lines, [ops]} = Enum.split(lines, -1)

    nums = Enum.zip_with(numbers_lines, & &1)

    %__MODULE__{data: Enum.zip(nums, ops)}
  end

  def from_file_p2(filename) do
    lines =
      filename
      |> File.read!()
      |> String.split("\n", trim: true)

    {numbers_lines, [ops]} = Enum.split(lines, -1)

    col_widths =
      ops
      |> String.split(~r/\*|\+/)
      |> tl()
      |> Enum.map(fn width -> String.length(width) + 1 end)

    nums =
      numbers_lines
      |> Enum.map(fn line -> chunk(line, col_widths, []) end)
      |> Enum.zip_with(& &1)
      |> Enum.map(fn nums ->
        nums
        |> Enum.map(&String.to_charlist/1)
        |> Enum.zip_with(& &1)
        |> Enum.map(&to_string/1)
        |> Enum.map(&String.trim/1)
        |> Enum.reject(&(&1 == ""))
      end)

    chunked_ops = chunk(ops, col_widths, [])

    ops = Enum.map(chunked_ops, &String.trim/1)

    %__MODULE__{data: Enum.zip(nums, ops)}
  end

  defp chunk(_line, [] = _widths, chunked), do: chunked

  defp chunk(line, [width | widths], chunked) do
    {chunk, rest} = String.split_at(line, width)
    chunk(rest, widths, [chunk | chunked])
  end

  def solve(%__MODULE__{data: data}) do
    Enum.sum_by(
      data,
      fn
        {nums, "*"} -> Enum.product_by(nums, &String.to_integer/1)
        {nums, "+"} -> Enum.sum_by(nums, &String.to_integer/1)
      end
    )
  end
end
