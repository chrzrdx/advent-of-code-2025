defmodule AdventOfCode2025.Day12 do
  alias AdventOfCode2025.Day12.Farm

  def solve_p1(filename) do
    filename
    |> Farm.from_file()
    |> Farm.solve_p1()
  end

  def solve_p2(filename) do
    filename
    |> Farm.from_file()
    |> Farm.solve_p2()
  end
end
