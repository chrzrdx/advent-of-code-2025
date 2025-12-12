defmodule AdventOfCode2025.Day09 do
  alias AdventOfCode2025.Day09.MovieTheater

  def solve_p1(filename) do
    filename
    |> MovieTheater.from_file()
    |> MovieTheater.solve_p1()
  end

  def solve_p2(filename) do
    filename
    |> MovieTheater.from_file()
    |> MovieTheater.solve_p2()
  end
end
