defmodule AdventOfCode2025.Day11Test do
  use ExUnit.Case
  import AdventOfCode2025.Day11, only: [solve_p1: 1, solve_p2: 1]

  @p1 "test/day/11/p1.txt"
  @p2 "test/day/11/p2.txt"
  @puzzle "test/day/11/puzzle.txt"

  describe "part 1" do
    @tag :skip
    test "example" do
      assert solve_p1(@p1) == 5
    end

    @tag :skip
    test "puzzle" do
      assert solve_p1(@puzzle) == 508
    end
  end

  describe "part 2" do
    test "example" do
      assert solve_p2(@p2) == 2
    end

    @tag :skip
    test "puzzle" do
      assert solve_p2(@puzzle) == 0
    end
  end
end
