defmodule AdventOfCode2025.Day06 do
  alias AdventOfCode2025.Day06.TrashCompactor

  def solve_p1(filename) do
    filename
    |> TrashCompactor.from_file_p1()
    |> TrashCompactor.solve()
  end

  def solve_p2(filename) do
    filename
    |> TrashCompactor.from_file_p2()
    |> TrashCompactor.solve()
  end
end
