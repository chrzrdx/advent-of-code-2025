defmodule AdventOfCode2025.Day07Test do
  use ExUnit.Case
  import AdventOfCode2025.Day07, only: [solve_p1: 1, solve_p2: 1]

  @p1 "test/day/07/p1.txt"
  @p2 "test/day/07/p2.txt"
  @puzzle "test/day/07/puzzle.txt"

  describe "part 1" do
    test "example" do
      assert solve_p1(@p1) == 21
    end

    test "puzzle" do
      assert solve_p1(@puzzle) == 1613
    end
  end

  describe "part 2" do
    test "example" do
      assert solve_p2(@p2) == 40
    end

    test "puzzle" do
      assert solve_p2(@puzzle) == 48_021_610_271_997
    end
  end
end
