defmodule AdventOfCode2025.Day02Test do
  use ExUnit.Case
  import AdventOfCode2025.Day02, only: [solve_p1: 1, solve_p2: 1]

  @p1 "test/day/02/p1.txt"
  @p2 "test/day/02/p2.txt"
  @puzzle "test/day/02/puzzle.txt"

  describe "part 1" do
    test "example" do
      assert solve_p1(@p1) == 1_227_775_554
    end

    test "puzzle" do
      assert solve_p1(@puzzle) == 16_793_817_782
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
