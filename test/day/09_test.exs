defmodule AdventOfCode2025.Day09Test do
  use ExUnit.Case
  import AdventOfCode2025.Day09, only: [solve_p1: 1, solve_p2: 1]

  @p1 "test/day/09/p1.txt"
  @p2 "test/day/09/p2.txt"
  @puzzle "test/day/09/puzzle.txt"

  describe "part 1" do
    test "example" do
      assert solve_p1(@p1) == 50
    end

    test "puzzle" do
      assert solve_p1(@puzzle) == 4_754_955_192
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      assert solve_p2(@p2) == 24
    end

    @tag :skip
    test "puzzle" do
      assert solve_p2(@puzzle) == 0
    end
  end
end
