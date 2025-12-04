defmodule AdventOfCode2025.Day04 do
  alias AdventOfCode2025.Day04.PrintingDepartment

  def solve_p1(filename) do
    filename
    |> PrintingDepartment.from_file()
    |> PrintingDepartment.solve_p1()
  end

  def solve_p2(filename) do
    filename
    |> PrintingDepartment.from_file()
    |> PrintingDepartment.solve_p2()
  end
end
