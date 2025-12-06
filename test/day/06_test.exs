defmodule AdventOfCode2025.Day06Test do
  use ExUnit.Case
  import AdventOfCode2025.Day06, only: [solve_p1: 1, solve_p2: 1]

  @p1 "test/day/06/p1.txt"
  @p2 "test/day/06/p2.txt"
  @puzzle "test/day/06/puzzle.txt"

  describe "part 1" do
    test "example" do
      assert solve_p1(@p1) == 4_277_556
    end

    test "puzzle" do
      assert solve_p1(@puzzle) == 6_503_327_062_445
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      assert solve_p2(@p2) == 0
    end

    @tag :skip
    test "puzzle" do
      assert solve_p2(@puzzle) == 0
    end
  end
end
