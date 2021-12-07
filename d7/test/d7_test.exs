defmodule D7Test do
  use ExUnit.Case
  doctest D7

  test "part 1" do
    input = """
    16,1,2,0,4,2,7,1,2,14
    """

    assert D7.p1(input) == 37
  end

  test "part 2" do
    input = """
    16,1,2,0,4,2,7,1,2,14
    """

    assert D7.p2(input) == 168
  end
end
