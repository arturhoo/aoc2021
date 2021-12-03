defmodule D3Test do
  use ExUnit.Case
  doctest D3

  test "part 1" do
    input = """
    00100
    11110
    10110
    10111
    10101
    01111
    00111
    11100
    10000
    11001
    00010
    01010
    """

    assert D3.p1(input) == 198
  end

  test "part 2" do
    input = """
    00100
    11110
    10110
    10111
    10101
    01111
    00111
    11100
    10000
    11001
    00010
    01010
    """

    assert D3.p2(input) == 230
  end
end
