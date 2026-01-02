defmodule AdventOfCode2025.Day09.MovieTheater do
  @moduledoc """
  Utility functions for Day 09.
  """

  defstruct [:points]

  def from_file(filename) do
    points =
      filename
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split(",", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)
      |> Enum.map(fn [x, y] -> {x, y} end)

    %__MODULE__{points: points}
  end

  def solve_p1(%__MODULE__{points: points}) do
    sorted_points = Enum.sort(points)

    for {x1, y1} <- sorted_points,
        {x2, y2} <- sorted_points,
        x1 < x2 do
      abs((x2 - x1 + 1) * (y2 - y1 + 1))
    end
    |> Enum.max()
  end

  def solve_p2(%__MODULE__{points: points}) do
    edges = get_polygon_edges(points)
    sorted_points = Enum.sort(points)

    for {x1, y1} <- sorted_points,
        {x2, y2} <- sorted_points,
        x1 < x2 and valid_rectangle?({{x1, y1}, {x2, y2}}, edges) do
      abs((x2 - x1 + 1) * (y2 - y1 + 1))
    end
    |> Enum.max()
  end

  defp get_polygon_edges(points) do
    rot_points = tl(points) ++ [hd(points)]
    Enum.zip(points, rot_points)
  end

  defp valid_rectangle?({{x1, y1}, {x2, y2}}, edges) do
    # are the two opposite corners inside the polygon?
    points_valid? = inside?({x1, y2}, edges) and inside?({x2, y1}, edges)
    edges_valid? = true

    points_valid? and edges_valid?
  end

  defp inside?(point, edges) do
    # count how many times the ray from the point to the right intersects the vertical edges
    # if odd, then the point is inside the polygon, else outside
    vert_edges = Enum.filter(edges, fn {{x1, _}, {x2, _}} -> x1 == x2 end)
    num_intersections = Enum.count(vert_edges, &intersects?(&1, point))
    rem(num_intersections, 2) == 1
  end

  def intersects?({{x, y1}, {x, y2}}, {x3, y3}) do
    to_left? = x3 <= x
    between_y? = (y3 >= y1 and y3 <= y2) or (y3 <= y1 and y3 >= y2)
    to_left? and between_y?
  end
end
