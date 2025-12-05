defmodule AdventOfCode2025.Day05 do
  alias AdventOfCode2025.Day05.Cafeteria

  def solve_p1(filename) do
    filename
    |> Cafeteria.from_file()
    |> Cafeteria.solve_p1()
  end

  def solve_p2(filename) do
    filename
    |> Cafeteria.from_file()
    |> Cafeteria.solve_p2()
  end
end
