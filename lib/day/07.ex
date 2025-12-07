defmodule AdventOfCode2025.Day07 do
  alias AdventOfCode2025.Day07.Labs

  def solve_p1(filename) do
    filename
    |> Labs.from_file()
    |> Labs.count_splits()
  end

  def solve_p2(filename) do
    filename
    |> Labs.from_file()
    |> Labs.count_paths()
  end
end
