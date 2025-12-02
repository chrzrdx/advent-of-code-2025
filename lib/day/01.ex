defmodule AdventOfCode2025.Day01 do
  @moduledoc """
  Day 01

  You're given a dial that starts at 50 and ends at 100. You can rotate the dial clockwise or counterclockwise.
  Part 1: Find the number of times the dial ends at 0 after each rotation.
  Part 2: Find the number of times the dial crosses 0 when carrying out the rotations.
  """

  alias AdventOfCode2025.Day01.Password

  def solve_p1(filename) do
    filename
    |> Password.from_file()
    |> Password.solve_p1()
  end

  def solve_p2(filename) do
    filename
    |> Password.from_file()
    |> Password.solve_p2()
  end
end
