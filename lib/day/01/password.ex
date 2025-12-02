defmodule AdventOfCode2025.Day01.Password do
  @moduledoc """
  Utility functions for Day 01.
  """

  defstruct [:data]

  @dial_starts_at 50
  @dial_ends_at 100

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
        {"R", rot} -> String.to_integer(rot)
        {"L", rot} -> -String.to_integer(rot)
      end
    end)
  end

  def solve_p1(%__MODULE__{data: rotations}) do
    {_final_pos, times_ends_at_zero} =
      Enum.reduce(
        rotations,
        {@dial_starts_at, 0},
        fn rot, {curr_pos, times_ends_at_zero} ->
          case new_pos = Integer.mod(curr_pos + rot, @dial_ends_at) do
            0 -> {new_pos, times_ends_at_zero + 1}
            _ -> {new_pos, times_ends_at_zero}
          end
        end
      )

    times_ends_at_zero
  end

  def solve_p2(%__MODULE__{data: rotations}) do
    {_final_pos, times_passes_zero} =
      Enum.reduce(
        rotations,
        {@dial_starts_at, 0},
        fn rot, {curr_pos, times_passes_zero} ->
          {new_pos, new_times_passes_zero} = passes_zero(curr_pos, rot)
          {new_pos, times_passes_zero + new_times_passes_zero}
        end
      )

    times_passes_zero
  end

  def passes_zero(curr_pos, to_rotate) when to_rotate > 0 do
    passed_zero_before_final_turn = Kernel.div(to_rotate, @dial_ends_at)
    remaining_rotations = Integer.mod(to_rotate, @dial_ends_at)

    next_pos = Integer.mod(curr_pos + remaining_rotations, @dial_ends_at)
    passed_zero_on_final_turn = Kernel.div(curr_pos + remaining_rotations, @dial_ends_at)

    {next_pos, passed_zero_before_final_turn + passed_zero_on_final_turn}
  end

  def passes_zero(curr_pos, to_rotate) when to_rotate < 0 do
    passed_zero_before_final_turn = Integer.floor_div(to_rotate, -@dial_ends_at)
    remaining_rotations = Integer.mod(to_rotate, -@dial_ends_at)

    next_pos = Integer.mod(curr_pos + remaining_rotations, @dial_ends_at)

    passed_zero_on_final_turn =
      cond do
        curr_pos == 0 -> 0
        curr_pos + remaining_rotations <= 0 -> 1
        true -> 0
      end

    {next_pos, passed_zero_before_final_turn + passed_zero_on_final_turn}
  end
end
