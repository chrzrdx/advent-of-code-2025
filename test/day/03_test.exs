defmodule AdventOfCode2025.Day03Test do
  use ExUnit.Case
  import AdventOfCode2025.Day03, only: [solve_p1: 1, solve_p2: 1]

  @p1 "test/day/03/p1.txt"
  @p2 "test/day/03/p2.txt"
  @puzzle "test/day/03/puzzle.txt"

  describe "part 1" do
    test "example" do
      assert solve_p1(@p1) == 357
    end

    test "puzzle" do
      assert solve_p1(@puzzle) == 17332
    end
  end

  describe "part 2" do
    test "example" do
      assert solve_p2(@p2) == 3_121_910_778_619
    end

    test "puzzle" do
      assert solve_p2(@puzzle) == 172_516_781_546_707
    end
  end
end
