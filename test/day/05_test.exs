defmodule AdventOfCode2025.Day05Test do
  use ExUnit.Case
  import AdventOfCode2025.Day05, only: [solve_p1: 1, solve_p2: 1]
  import AdventOfCode2025.Day05.Cafeteria, only: [from_file: 1]

  @p1 "test/day/05/p1.txt"
  @p2 "test/day/05/p2.txt"
  @puzzle "test/day/05/puzzle.txt"

  describe "part 1" do
    test "from_file" do
      data = from_file(@p1)
      assert data.ingredients == [1, 5, 8, 11, 17, 32]
      assert data.ranges == [3..5, 10..20]
    end

    test "example" do
      assert solve_p1(@p1) == 3
    end

    test "puzzle" do
      assert solve_p1(@puzzle) == 679
    end
  end

  describe "part 2" do
    test "example" do
      assert solve_p2(@p2) == 14
    end

    test "puzzle" do
      assert solve_p2(@puzzle) == 358_155_203_664_116
    end
  end
end
