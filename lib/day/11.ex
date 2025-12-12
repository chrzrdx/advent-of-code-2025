defmodule AdventOfCode2025.Day11 do
  alias AdventOfCode2025.Day11.Reactor

  def solve_p1(filename) do
    filename
    |> Reactor.from_file()
    |> Reactor.solve_p1()
  end

  def solve_p2(filename) do
    filename
    |> Reactor.from_file()
    |> Reactor.solve_p2()
  end
end
