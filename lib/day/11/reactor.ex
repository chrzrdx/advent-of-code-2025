defmodule AdventOfCode2025.Day11.Reactor do
  @moduledoc """
  Utility functions for Day 11.
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
    lines
    |> Enum.flat_map(fn line ->
      [device, outputs] = String.split(line, ":", trim: true)

      outputs
      |> String.split(" ", trim: true)
      |> Enum.map(fn output -> {String.to_atom(device), String.to_atom(output)} end)
    end)
    |> Enum.group_by(fn {device, _output} -> device end, fn {_device, output} -> output end)
  end

  def solve_p1(%__MODULE__{data: data}) do
    paths(data, :you, 0)
  end

  def paths(_data, :out, count), do: count + 1

  def paths(data, source, count) do
    if data[source] do
      data[source]
      |> Enum.map(fn output -> paths(data, output, count) end)
      |> Enum.sum()
    else
      count
    end
  end

  def solve_p2(%__MODULE__{data: data}) do
    data
  end
end
