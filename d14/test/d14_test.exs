defmodule D14Test do
  use ExUnit.Case
  doctest D14

  setup do
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

    {:ok, input: input}
  end

  test "part 1", %{input: input} = _ do
    assert D14.p1(input) == 1588
  end

  test "part 2", %{input: input} = _ do
    assert D14.p2(input) == 2_188_189_693_529
  end

  test 'Deriving pairs works for BBB' do
    assert D14.derive_pairs(["B", "B", "B"]) == ["BB", "BB"]
  end

  test 'Smart development from BBNBB to BNBBNBBNB works' do
    assert D14.develop_polymer_smart(
             %D14{
               elem_freq: %{"B" => 4, "N" => 1},
               pair_freq: %{"BB" => 2, "BN" => 1, "NB" => 1},
               pair_rules: %{"BB" => "N", "NB" => "B", "BN" => "B"}
             },
             1
           ) ==
             %D14{
               elem_freq: %{"B" => 6, "N" => 3},
               pair_freq: %{"BB" => 2, "BN" => 3, "NB" => 3},
               pair_rules: %{"BB" => "N", "NB" => "B", "BN" => "B"}
             }
  end
end
