defmodule AdventOfCode2025.Day08 do
  alias AdventOfCode2025.Day08.Playground

  def solve_p1(filename) do
    filename
    |> Playground.from_file()
    |> Playground.solve_p1(10)
  end

  def solve_p1_puzzle(filename) do
    filename
    |> Playground.from_file()
    |> Playground.solve_p1(1000)
  end

  def solve_p2(filename) do
    filename
    |> Playground.from_file()
    |> Playground.solve_p2()
  end
end
