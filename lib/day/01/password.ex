defmodule AdventOfCode2025.Day01.Password do
  @moduledoc """
  Utility functions for Day 01.
  """
  import Integer, only: [floor_div: 2, mod: 2]

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
          case new_pos = mod(curr_pos + rot, @dial_ends_at) do
            0 -> {new_pos, times_ends_at_zero + 1}
            _ -> {new_pos, times_ends_at_zero}
          end
        end
      )

    times_ends_at_zero
  end

  def solve_p2(%__MODULE__{data: rotations}) do
    {_final_pos, times_passed_zero} =
      Enum.reduce(
        rotations,
        {@dial_starts_at, 0},
        fn rot, {curr_pos, times_passed_zero} ->
          new_pos = mod(curr_pos + rot, @dial_ends_at)

          # get completed and remaining turns
          # you cross zero once on every complete turn
          {completed, remaining} =
            if rot > 0 do
              {floor_div(rot, @dial_ends_at), mod(rot, @dial_ends_at)}
            else
              {floor_div(rot, -@dial_ends_at), mod(rot, -@dial_ends_at)}
            end

          passes_on_final_turn =
            cond do
              curr_pos == 0 -> 0
              remaining == 0 -> 0
              remaining > 0 -> floor_div(curr_pos + remaining, @dial_ends_at)
              remaining < 0 -> floor_div(curr_pos + remaining, -@dial_ends_at) + 1
            end

          {new_pos, times_passed_zero + completed + passes_on_final_turn}
        end
      )

    times_passed_zero
  end
end
