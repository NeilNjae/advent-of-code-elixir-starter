defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Day01

  # @tag :skip
  test "part1" do
    input = AdventOfCode.Input.get!(1, "a")
    result = part1(input)

    assert result == 11
  end

  # @tag :skip
  test "part2" do
    input = AdventOfCode.Input.get!(1, "a")
    result = part2(input)

    assert result == 31
  end
end
