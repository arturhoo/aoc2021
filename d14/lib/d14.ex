defmodule D14 do
  def p1(input) do
    {template, pairs} = parse_input(input)

    polymer =
      Enum.reduce(0..9, [template], fn _, acc -> [insert_pairs(List.first(acc), pairs) | acc] end)
      |> List.first()

    freq = Enum.frequencies(polymer)
    Enum.max(Map.values(freq)) - Enum.min(Map.values(freq))
  end

  def p2(_input) do
    :hello
  end

  defp parse_input(input) do
    [template_str | pairs] = String.split(input, "\n", trim: true)

    pairs =
      pairs
      |> Enum.map(&String.split(&1, " -> "))
      |> Map.new(fn [k, v] -> {k, v} end)

    {String.codepoints(template_str), pairs}
  end

  defp insert_pairs([e1, e2], pairs) do
    [e1, pairs[e1 <> e2], e2]
  end

  defp insert_pairs([e1 | [e2 | tail]], pairs) do
    [e1, pairs[e1 <> e2] | insert_pairs([e2 | tail], pairs)]
  end
end
