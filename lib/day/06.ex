defmodule AdventOfCode2025.Day06 do
  alias AdventOfCode2025.Day06.TrashCompactor

  def solve_p1(filename) do
    filename
    |> TrashCompactor.from_file()
    |> TrashCompactor.solve_p1()
  end

  def solve_p2(filename) do
    filename
    |> TrashCompactor.from_file()
    |> TrashCompactor.solve_p2()
  end
end
