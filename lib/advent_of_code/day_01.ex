
defmodule AdventOfCode.Day01 do
  require Logger
  use Flow

  def part1(input \\ nil) do
    input = if is_nil(input), do: AdventOfCode.Input.get!(1), else: input
    {lefts, rights} = parse_input(input)
    s_lefts = Enum.sort(lefts)
    s_rights = Enum.sort(rights)

    Enum.zip(s_lefts, s_rights)
    |> Enum.map(fn {l, r} -> abs(l - r) end)
    |> Enum.sum()
  end

  def part2(input \\ nil) do
    input = if is_nil(input), do: AdventOfCode.Input.get!(1), else: input
    {lefts, rights} = parse_input(input)

    right_counts = rights
    |> Flow.from_enumerable()
    |> Flow.partition(key: fn x -> rem(x, 100) end)
    |> Flow.reduce(fn -> %{} end, fn item, acc ->
          Map.update(acc, item, 1, &(&1 + 1))
          end)
    |> Enum.reduce(%{}, fn {n, c}, acc -> Map.merge(%{n => c}, acc) end)

    # right_counts = Enum.frequencies(rights)

    similarity =
      lefts
      |> Enum.map(fn x -> x * Map.get(right_counts, x, 0) end)
      |> Enum.sum()

    similarity
  end

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Task.async_stream(&parse_line/1, ordered: false)
    |> Enum.map(fn r -> elem(r, 1) end)
    |> Enum.unzip()

    # |> String.split("\n")
    # |> Enum.map(&String.split/1)
    # # |> Enum.map(fn xs -> xs |> Enum.map(&String.to_integer/1) end)
    # |> Enum.map(fn xs -> Enum.map(xs, &String.to_integer/1) end)
    # |> Enum.map(fn xs -> {Enum.at(xs, 0), Enum.at(xs, 1)} end)
    # |> Enum.unzip()
  end

  defp parse_line(inline) do
    lp = inline
          |> String.split()
          |> Enum.map(&String.to_integer/1)
    {Enum.at(lp, 0), Enum.at(lp, 1)}
  end
end
