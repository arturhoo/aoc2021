defmodule D3 do
  def p1(input) do
    occurrances =
      String.split(input)
      |> Enum.map(&String.graphemes/1)
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(&Enum.frequencies/1)

    gamma = rate_value(Enum.reverse(occurrances), {0, 0}, :gamma)
    epsilon = rate_value(Enum.reverse(occurrances), {0, 0}, :epsilon)
    gamma * epsilon
  end

  def rate_value([head | tail], {digits_count, acc}, rate_type) do
    rate_fn =
      case rate_type do
        :gamma -> &Enum.max/1
        :epsilon -> &Enum.min/1
      end

    saught_val = head |> Map.values() |> rate_fn.()
    digit = head |> Enum.find(fn {_, val} -> val == saught_val end) |> elem(0)

    acc =
      case digit do
        "1" -> acc + Integer.pow(2, digits_count)
        "0" -> acc
      end

    rate_value(tail, {digits_count + 1, acc}, rate_type)
  end

  def rate_value([], {_, acc}, _) do
    acc
  end
end
