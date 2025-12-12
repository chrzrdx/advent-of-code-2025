defmodule AdventOfCode2025.Day10 do
  alias AdventOfCode2025.Day10.Factory

  def solve_p1(filename) do
    filename
    |> Factory.from_file()
    |> Factory.solve_p1()
  end

  def solve_p2(filename) do
    filename
    |> Factory.from_file()
    |> Factory.solve_p2()
  end
end
