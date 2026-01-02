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
    paths(data, :you, :out, 0)
  end

  def paths(_data, source, dest, count) when source == dest,
    do: (count + 1) |> IO.inspect(label: "arrived at dest #{dest}")

  def paths(data, source, _dest, _count) when not is_map_key(data, source),
    do: 0 |> IO.inspect(label: "#{source} is a dead end")

  def paths(data, source, dest, count) do
    data[source]
    |> IO.inspect(label: "data[source]")
    |> Enum.map(fn output ->
      paths(data, output, dest, count)
    end)
    |> Enum.sum()
    |> IO.inspect(label: "paths from #{source} to #{dest}")
  end

  def solve_p2(%__MODULE__{data: data}) do
    IO.inspect(data, label: "data")

    srv_to_dac = paths(data, :svr, :dac, 0) |> IO.inspect(label: "srv_to_dac")
    dac_to_fft = paths(data, :dac, :fft, 0) |> IO.inspect(label: "dac_to_fft")
    fft_to_out = paths(data, :fft, :out, 0) |> IO.inspect(label: "fft_to_out")
    srv_to_fft = paths(data, :svr, :fft, 0) |> IO.inspect(label: "srv_to_fft")
    fft_to_dac = paths(data, :fft, :dac, 0) |> IO.inspect(label: "fft_to_dac")
    dac_to_out = paths(data, :dac, :out, 0) |> IO.inspect(label: "dac_to_out")

    srv_to_dac_to_fft_to_out = srv_to_dac * dac_to_fft * fft_to_out
    srv_to_fft_to_dac_to_out = srv_to_fft * fft_to_dac * dac_to_out

    srv_to_dac_to_fft_to_out + srv_to_fft_to_dac_to_out
  end
end
