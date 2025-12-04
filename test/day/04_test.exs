defmodule AdventOfCode2025.Day04Test do
  use ExUnit.Case
  import AdventOfCode2025.Day04, only: [solve_p1: 1, solve_p2: 1]

  @p1 "test/day/04/p1.txt"
  @p2 "test/day/04/p2.txt"
  @puzzle "test/day/04/puzzle.txt"

  describe "part 1" do
    test "example" do
      assert solve_p1(@p1) == 13
    end

    test "puzzle" do
      assert solve_p1(@puzzle) == 1416
    end
  end

  describe "part 2" do
    test "example" do
      assert solve_p2(@p2) == 43
    end

    test "puzzle" do
      assert solve_p2(@puzzle) == 9086
    end
  end
end
