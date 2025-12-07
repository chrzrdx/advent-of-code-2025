defmodule AdventOfCode2025.Day07 do
  alias AdventOfCode2025.Day07.Labs

  def solve_p1(filename) do
    filename
    |> Labs.from_file()
    |> Labs.solve_p1()
  end

  def solve_p2(filename) do
    filename
    |> Labs.from_file()
    |> Labs.solve_p2()
  end
end
