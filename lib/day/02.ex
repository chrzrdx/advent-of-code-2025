defmodule AdventOfCode2025.Day02 do
  @moduledoc """
  Solutions for Advent of Code 2025, Day 02.
  """

  alias AdventOfCode2025.Day02.GiftShop

  def solve_p1(filename) do
    filename
    |> GiftShop.from_file()
    |> GiftShop.solve_p1()
  end

  def solve_p2(filename) do
    filename
    |> GiftShop.from_file()
    |> GiftShop.solve_p2()
  end
end
