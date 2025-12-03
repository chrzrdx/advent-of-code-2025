defmodule AdventOfCode2025.Day03 do
  @moduledoc """
  Solutions for Advent of Code 2025, Day 03.
  """

  alias AdventOfCode2025.Day03.Lobby

  def solve_p1(filename) do
    filename
    |> Lobby.from_file()
    |> Lobby.solve_p1()
  end

  def solve_p2(filename) do
    filename
    |> Lobby.from_file()
    |> Lobby.solve_p2()
  end
end
