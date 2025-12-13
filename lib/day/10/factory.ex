defmodule AdventOfCode2025.Day10.Factory do
  @moduledoc """
  Utility functions for Day 10.
  """

  import Bitwise

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
    |> Enum.map(fn line ->
      [a, rest] = String.split(line, "]", trim: true)
      [b, c] = String.split(rest, "{", trim: true)

      diagram_str =
        a
        |> String.trim("[")

      diagram =
        diagram_str
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.filter(fn
          {"#", _} -> true
          _ -> false
        end)
        |> Enum.map(fn {_k, v} -> v end)

      buttons =
        b
        |> String.split(" ", trim: true)
        |> Enum.map(fn x ->
          x
          |> String.trim("(")
          |> String.trim(")")
          |> String.split(",")
          |> Enum.map(&String.to_integer/1)
          |> get_binary_mask()
        end)

      joltages =
        c
        |> String.trim("}")
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)

      %{
        diagram: %{mask: get_binary_mask(diagram), length: String.length(diagram_str)},
        buttons: buttons,
        joltages: joltages
      }
    end)
  end

  defp get_binary_mask(nums) do
    Enum.sum_by(nums, fn n -> 1 <<< n end)
  end

  def solve_p1(%__MODULE__{data: data}) do
    Enum.sum_by(data, fn %{diagram: diagram, buttons: buttons} ->
      min_presses(diagram, buttons)
    end)
  end

  defp min_presses(%{mask: target, length: max_possible_presses}, buttons) do
    for presses_left <- 0..max_possible_presses do
      # IO.inspect({target, 0, presses_left, buttons, max_possible_presses}, label: "investigate")
      solved? = can_solve?(target, 0, presses_left, buttons)
      if solved?, do: presses_left, else: 10000
    end
    |> Enum.min()
  end

  defp can_solve?(target, target, _, _), do: true
  defp can_solve?(_target, _num, 0 = _presses_left, _buttons_left), do: false
  defp can_solve?(_target, _num, _presses_left, [] = _buttons_left), do: false

  defp can_solve?(target, num, presses_left, [button | buttons]) do
    # IO.inspect({target, num, presses_left, [button | buttons]})
    # don't press button
    # press button
    can_solve?(target, num, presses_left, buttons) or
      can_solve?(target, bxor(num, button), presses_left - 1, buttons)
  end

  def solve_p2(%__MODULE__{data: data}) do
    # TODO: Implement part 2
    data
  end
end
