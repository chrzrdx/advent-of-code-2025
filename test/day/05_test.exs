defmodule AdventOfCode2025.Day05Test do
  use ExUnit.Case
  import AdventOfCode2025.Day05, only: [solve_p1: 1, solve_p2: 1]

  @p1 "test/day/05/p1.txt"
  @p2 "test/day/05/p2.txt"
  @puzzle "test/day/05/puzzle.txt"

  describe "part 1" do
    test "example" do
      assert solve_p1(@p1) == 3
    end

    test "puzzle" do
      assert solve_p1(@puzzle) == 679
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      assert solve_p2(@p2) == 14
    end

    @tag :skip
    test "puzzle" do
      assert solve_p2(@puzzle) == 0
    end
  end
end
