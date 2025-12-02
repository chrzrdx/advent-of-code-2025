defmodule Mix.Tasks.Scaffold do
  @moduledoc "Printed when the user requests `mix help scaffold`"
  @shortdoc "Generates scaffold files for a new day's puzzle"

  use Mix.Task

  @impl Mix.Task
  def run([day, module_name]) do
    validate_day!(day)

    module = %{
      pascal_case: module_name |> String.split("_") |> Enum.map_join("", &String.capitalize/1),
      snake_case: module_name |> String.split("_") |> Enum.map_join("_", &String.downcase/1)
    }

    with :ok <- create_directories(day),
         :ok <- create_module_file(day, module),
         :ok <- create_main_file(day, module),
         :ok <- create_test_file(day),
         :ok <- create_fixture_files(day) do
      Mix.shell().info([:green, "\n✓ Successfully created scaffold for Day #{day}\n"])
    end
  end

  defp validate_day!(day) do
    case Integer.parse(day) do
      {num, ""} when num in 1..12 -> :ok
      _ -> Mix.raise("Day must be a number between 1 and 12")
    end
  end

  defp create_directories(day) do
    File.mkdir_p!("lib/day/#{day}")
    File.mkdir_p!("test/day/#{day}")
    :ok
  end

  defp create_file(path, content) do
    if File.exists?(path) do
      Mix.shell().info([:yellow, "File #{path} already exists, skipping..."])
    else
      File.write!(path, content)
      Mix.shell().info([:green, "Created #{path}"])
    end

    :ok
  end

  defp create_module_file(day, module) do
    content = """
    defmodule AdventOfCode2025.Day#{day}.#{module.pascal_case} do
      @moduledoc \"\"\"
      Utility functions for Day #{day}.
      \"\"\"

      defstruct [:data]

      def from_file(filename) do
        data =
          filename
          |> File.read!()
          |> String.split("\\n", trim: true)
          |> parse_lines()

        %__MODULE__{data: data}
      end

      defp parse_lines(lines) do
        Enum.map(lines, fn line ->
          String.split(line, " ", trim: true)
        end)
      end

      def solve_p1(%__MODULE__{data: data}) do
        # TODO: Implement part 1
        data
      end

      def solve_p2(%__MODULE__{data: data}) do
        # TODO: Implement part 2
        data
      end
    end
    """

    create_file("lib/day/#{day}/#{module.snake_case}.ex", content)
  end

  defp create_main_file(day, module) do
    content = """
    defmodule AdventOfCode2025.Day#{day} do
      alias AdventOfCode2025.Day#{day}.#{module.pascal_case}

      def solve_p1(filename) do
        filename
        |> #{module.pascal_case}.from_file()
        |> #{module.pascal_case}.solve_p1()
      end

      def solve_p2(filename) do
        filename
        |> #{module.pascal_case}.from_file()
        |> #{module.pascal_case}.solve_p2()
      end
    end
    """

    create_file("lib/day/#{day}.ex", content)
  end

  defp create_test_file(day) do
    content = """
    defmodule AdventOfCode2025.Day#{day}Test do
      use ExUnit.Case
      import AdventOfCode2025.Day#{day}, only: [solve_p1: 1, solve_p2: 1]

      @p1 "test/day/#{day}/p1.txt"
      @p2 "test/day/#{day}/p2.txt"
      @puzzle "test/day/#{day}/puzzle.txt"

      describe "part 1" do
        test "example" do
          assert solve_p1(@p1) == 0
        end

        @tag :skip
        test "puzzle" do
          assert solve_p1(@puzzle) == 0
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
    """

    create_file("test/day/#{day}_test.exs", content)
  end

  defp create_fixture_files(day) do
    create_file("test/day/#{day}/p1.txt", "")
    create_file("test/day/#{day}/p2.txt", "")
    create_file("test/day/#{day}/puzzle.txt", "")
  end
end
