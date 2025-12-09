defmodule AdventOfCode2025.Day08.Playground do
  @moduledoc """
  Utility functions for Day 08.
  """

  defstruct [:points, :clusters]

  def from_file(filename) do
    points =
      filename
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split(",", trim: true)
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)

    points_with_index = points |> Enum.with_index()
    points_map = points_with_index |> Map.new()

    clusters_map = Map.new(points_with_index, fn {p, idx} -> {idx, MapSet.new([p])} end)

    %__MODULE__{points: points_map, clusters: clusters_map}
  end

  def solve_p1(playground, conns_to_make) do
    connections = pairwise_distances(playground) |> Enum.take(conns_to_make)

    %{clusters: clusters} =
      Enum.reduce(connections, playground, fn {p1, p2, _}, playground ->
        merge_clusters(playground, {p1, p2})
      end)

    clusters
    |> Enum.map(fn {_, cluster} -> MapSet.size(cluster) end)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  def solve_p2(playground) do
    connections = pairwise_distances(playground)
    {p1, p2} = merge_until_one_cluster(playground, connections)
    elem(p1, 0) * elem(p2, 0)
  end

  defp pairwise_distances(%__MODULE__{points: points}) do
    for {p1, i} <- points,
        {p2, j} <- points,
        i < j do
      {p1, p2, distance(p1, p2)}
    end
    |> Enum.sort_by(fn {_, _, distance} -> distance end)
  end

  defp distance({x1, y1, z1}, {x2, y2, z2}) do
    (x1 - x2) ** 2 + (y1 - y2) ** 2 + (z1 - z2) ** 2
  end

  defp merge_clusters(%__MODULE__{points: points, clusters: clusters} = data, {p1, p2}) do
    cond do
      points[p1] == points[p2] ->
        data

      points[p1] > points[p2] ->
        merge_clusters(data, {p2, p1})

      true ->
        combined_cluster = MapSet.union(clusters[points[p1]], clusters[points[p2]])
        new_points = combined_cluster |> MapSet.to_list() |> Map.from_keys(points[p1])

        %__MODULE__{
          points: Map.merge(points, new_points),
          clusters:
            clusters
            |> Map.delete(points[p2])
            |> Map.put(points[p1], combined_cluster)
        }
    end
  end

  defp merge_until_one_cluster(playground, [{p1, p2, _} | rest_connections]) do
    new_playground = merge_clusters(playground, {p1, p2})
    %{clusters: clusters} = new_playground

    if map_size(clusters) == 1 do
      {p1, p2}
    else
      merge_until_one_cluster(new_playground, rest_connections)
    end
  end
end
