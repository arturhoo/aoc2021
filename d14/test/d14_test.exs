defmodule D14Test do
  use ExUnit.Case
  doctest D14

  test "part 1" do
    input = """
    NNCB

    CH -> B
    HH -> N
    CB -> H
    NH -> C
    HB -> C
    HC -> B
    HN -> C
    NN -> C
    BH -> H
    NC -> B
    NB -> B
    BN -> B
    BB -> N
    BC -> B
    CC -> N
    CN -> C
    """

    assert D14.p1(input) == 1588
  end

  test "part 2" do
    input = """
    NNCB

    CH -> B
    HH -> N
    CB -> H
    NH -> C
    HB -> C
    HC -> B
    HN -> C
    NN -> C
    BH -> H
    NC -> B
    NB -> B
    BN -> B
    BB -> N
    BC -> B
    CC -> N
    CN -> C
    """

    assert D14.p2(input) == 2_188_189_693_529
  end

  test 'Deriving pairs works for BBB' do
    assert D14.derive_pairs(["B", "B", "B"]) == ["BB", "BB"]
  end

  BBB
  BNBNB

  test 'Smart development from BBNBB to BNBBNBBNB works' do
    assert D14.develop_polymer_smart(
             %{"B" => 4, "N" => 1},
             %{"BB" => 2, "BN" => 1, "NB" => 1},
             %{"BB" => "N", "NB" => "B", "BN" => "B"},
             1
           ) ==
             {%{"B" => 6, "N" => 3}, %{"BB" => 2, "BN" => 3, "NB" => 3}}
  end
end
