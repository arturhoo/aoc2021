defmodule D14 do
  defstruct elem_freq: %{}, pair_freq: %{}, pair_rules: %{}

  def p1(input) do
    {template, pair_rules} = parse_input(input)
    polymer = develop_polymer_naive(template, pair_rules, 10)
    elem_freq = Enum.frequencies(polymer)
    Enum.max(Map.values(elem_freq)) - Enum.min(Map.values(elem_freq))
  end

  def p2(input) do
    {template, pair_rules} = parse_input(input)

    elem_freq = Enum.frequencies(template)
    pairs = derive_pairs(template)
    pair_freq = Enum.frequencies(pairs)

    %D14{elem_freq: elem_freq} =
      %D14{elem_freq: elem_freq, pair_freq: pair_freq, pair_rules: pair_rules}
      |> develop_polymer_smart(40)

    Enum.max(Map.values(elem_freq)) - Enum.min(Map.values(elem_freq))
  end

  defp parse_input(input) do
    [template_str | pairs_line] = String.split(input, "\n", trim: true)

    pairs =
      pairs_line
      |> Enum.map(&String.split(&1, " -> "))
      |> Map.new(fn [k, v] -> {k, v} end)

    {String.codepoints(template_str), pairs}
  end

  defp develop_polymer_naive(polymer, pair_rules, steps) do
    Enum.reduce(0..(steps - 1), polymer, fn _, polymer ->
      insert_elements(polymer, pair_rules)
    end)
  end

  defp insert_elements([e1, e2], pair_rules), do: [e1, pair_rules[e1 <> e2], e2]

  defp insert_elements([e1 | [e2 | tail]], pairs) do
    [e1, pairs[e1 <> e2] | insert_elements([e2 | tail], pairs)]
  end

  def derive_pairs([e1, e2]), do: [e1 <> e2]
  def derive_pairs([e1 | [e2 | tail]]), do: [e1 <> e2 | derive_pairs([e2 | tail])]

  def develop_polymer_smart(container, steps) do
    Enum.reduce(0..(steps - 1), container, fn _, container ->
      develop_polymer_smart_once(container)
    end)
  end

  defp develop_polymer_smart_once(container) do
    Enum.reduce(container.pair_freq, container, fn {pair, freq}, container ->
      [l, r] = String.codepoints(pair)
      new_elem = container.pair_rules[pair]
      elem_freq = increment_key_by(container.elem_freq, new_elem, freq)

      pair_freq =
        container.pair_freq
        |> increment_key_by(pair, -freq)
        |> increment_key_by(l <> new_elem, freq)
        |> increment_key_by(new_elem <> r, freq)

      %{container | elem_freq: elem_freq, pair_freq: pair_freq}
    end)
  end

  defp increment_key_by(map, key, x), do: Map.put(map, key, Map.get(map, key, 0) + x)
end
