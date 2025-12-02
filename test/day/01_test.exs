defmodule AdventOfCode2025.Day01Test do
  use ExUnit.Case
  import AdventOfCode2025.Day01, only: [solve_p1: 1, solve_p2: 1]

  @p1 "test/day/01/p1.txt"
  @p2 "test/day/01/p2.txt"
  @puzzle "test/day/01/puzzle.txt"

  describe "part 1" do
    test "example" do
      assert solve_p1(@p1) == 3
    end

    test "puzzle" do
      assert solve_p1(@puzzle) == 1168
    end
  end

  describe "part 2" do
    test "example" do
      assert solve_p2(@p2) == 6
    end

    test "puzzle" do
      assert solve_p2(@puzzle) == 7199
    end
  end
end
