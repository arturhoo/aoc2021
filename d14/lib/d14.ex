defmodule D14 do
  @spec p1(binary) :: number
  def p1(input) do
    {template, pairs} = parse_input(input)
    polymer = develop_polymer_naive(template, pairs, 10)
    freq = Enum.frequencies(polymer)
    Enum.max(Map.values(freq)) - Enum.min(Map.values(freq))
  end

  @spec p2(binary) :: number
  def p2(input) do
    {template, pair_rules} = parse_input(input)

    elem_freq = Enum.frequencies(template)
    pairs = derive_pairs(template)
    pair_freq = Enum.frequencies(pairs)
    {elem_freq, _} = develop_polymer_smart(elem_freq, pair_freq, pair_rules, 40)
    Enum.max(Map.values(elem_freq)) - Enum.min(Map.values(elem_freq))
  end

  defp parse_input(input) do
    [template_str | pairs] = String.split(input, "\n", trim: true)

    pairs =
      pairs
      |> Enum.map(&String.split(&1, " -> "))
      |> Map.new(fn [k, v] -> {k, v} end)

    {String.codepoints(template_str), pairs}
  end

  defp develop_polymer_naive(polymer, pairs, steps) do
    Enum.reduce(0..(steps - 1), [polymer], fn _, acc ->
      [insert_elements(List.first(acc), pairs) | acc]
    end)
    |> List.first()
  end

  defp insert_elements([e1, e2], pairs) do
    [e1, pairs[e1 <> e2], e2]
  end

  defp insert_elements([e1 | [e2 | tail]], pairs) do
    [e1, pairs[e1 <> e2] | insert_elements([e2 | tail], pairs)]
  end

  def derive_pairs([e1, e2]), do: [e1 <> e2]
  def derive_pairs([e1 | [e2 | tail]]), do: [e1 <> e2 | derive_pairs([e2 | tail])]

  def develop_polymer_smart(elem_freq, pair_freq, pair_rules, steps) do
    Enum.reduce(0..(steps - 1), {elem_freq, pair_freq}, fn _, {elem_freq, pair_freq} ->
      develop_polymer_smart_once(elem_freq, pair_freq, pair_rules)
    end)
  end

  defp develop_polymer_smart_once(elem_freq, pair_freq, pair_rules) do
    Enum.reduce(pair_freq, {elem_freq, pair_freq}, fn {pair, freq}, {elem_freq, pair_freq} ->
      new_elem = pair_rules[pair]
      elem_freq = Map.put(elem_freq, new_elem, Map.get(elem_freq, new_elem, 0) + freq)

      [l, r] = String.codepoints(pair)
      pair_freq = Map.put(pair_freq, pair, pair_freq[pair] - freq)
      pair_freq = Map.put(pair_freq, l <> new_elem, Map.get(pair_freq, l <> new_elem, 0) + freq)
      pair_freq = Map.put(pair_freq, new_elem <> r, Map.get(pair_freq, new_elem <> r, 0) + freq)

      {elem_freq, pair_freq}
    end)
  end
end
