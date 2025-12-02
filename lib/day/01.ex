defmodule AdventOfCode2025.Day01 do
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
