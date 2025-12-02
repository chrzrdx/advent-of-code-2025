# IEx Configuration for Advent of Code 2025

# Configure IEx
IEx.configure(
  auto_reload: true,
  colors: [
    enabled: true,
    eval_result: [:cyan, :bright],
    eval_error: [:red, :bright],
    eval_info: [:yellow, :bright]
  ],
  history_size: 10000,
  inspect: [
    pretty: true,
    limit: :infinity,
    width: 120
  ],
  default_prompt: "%prefix(%counter)>",
  alive_prompt: "%prefix(%node)%counter>"
)

# Helper functions for Advent of Code
defmodule A do
  @moduledoc """
  Convenience functions for testing Advent of Code 2025 solutions in IEx.
  """

  @doc "Run part 1 for a given day with example input"
  def p1(day, input \\ "example") do
    day_str = String.pad_leading("#{day}", 2, "0")
    module = Module.concat([AdventOfCode2025, :"Day#{day_str}"])
    module.solve_p1("test/day/#{day_str}/#{input}.txt")
  end

  @doc "Run part 2 for a given day with example input"
  def p2(day, input \\ "example") do
    day_str = String.pad_leading("#{day}", 2, "0")
    module = Module.concat([AdventOfCode2025, :"Day#{day_str}"])
    module.solve_p2("test/day/#{day_str}/#{input}.txt")
  end

  @doc "Run both parts for a given day with example input"
  def both(day, input \\ "example") do
    IO.puts("Part 1: #{p1(day, input)}")
    IO.puts("Part 2: #{p2(day, input)}")
  end

  @doc "Run part 1 with puzzle input"
  def puzzle1(day), do: p1(day, "puzzle")

  @doc "Run part 2 with puzzle input"
  def puzzle2(day), do: p2(day, "puzzle")

  @doc "Read a fixture file"
  def read(day, name \\ "example") do
    day_str = String.pad_leading("#{day}", 2, "0")
    File.read!("test/day/#{day_str}/#{name}.txt")
  end

  @doc "Parse a fixture file into lines"
  def lines(day, name \\ "example") do
    day
    |> read(name)
    |> String.split("\n", trim: true)
  end

  @doc "Benchmark a function"
  def bench(fun) when is_function(fun) do
    {time, result} = :timer.tc(fun)
    IO.puts("Time: #{time / 1000} ms")
    result
  end
end

# Aliases for convenience
alias AdventOfCode2025, as: A

# Welcome message
IO.puts("""

#{IO.ANSI.cyan()}╔════════════════════════════════════════════╗
║  Advent of Code 2025 - IEx Session Ready   ║
╚════════════════════════════════════════════╝#{IO.ANSI.reset()}

#{IO.ANSI.yellow()}Helpful commands:#{IO.ANSI.reset()}
  #{IO.ANSI.green()}A.p1(1)#{IO.ANSI.reset()}                - Run day 1 part 1 with example input
  #{IO.ANSI.green()}A.p2(1, "puzzle")#{IO.ANSI.reset()}      - Run day 1 part 2 with puzzle input
  #{IO.ANSI.green()}A.both(1)#{IO.ANSI.reset()}              - Run both parts with example input
  #{IO.ANSI.green()}A.read(1)#{IO.ANSI.reset()}              - Read example input for day 1
  #{IO.ANSI.green()}A.lines(1)#{IO.ANSI.reset()}             - Get lines from example input
  #{IO.ANSI.green()}A.bench(fn -> ... end)#{IO.ANSI.reset()} - Benchmark a function

#{IO.ANSI.cyan()}Happy coding! 🎄#{IO.ANSI.reset()}
""")

