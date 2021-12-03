defmodule D3 do
  def p1(input) do
    list_of_numbers = String.split(input)
    frequencies = calc_frequencies(list_of_numbers)

    gamma = rate_value(Enum.reverse(frequencies), {0, 0}, :gamma)
    epsilon = rate_value(Enum.reverse(frequencies), {0, 0}, :epsilon)
    gamma * epsilon
  end

  def p2(input) do
    oxygen = String.split(input) |> rating_value(0, :oxygen)
    co2 = String.split(input) |> rating_value(0, :co2)
    oxygen * co2
  end

  defp calc_frequencies(list_of_numbers) do
    list_of_numbers
    |> Enum.map(&String.graphemes/1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.frequencies/1)
  end

  defp rate_value([head | tail], {digits_count, acc}, rate_type) do
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

  defp rate_value([], {_, acc}, _) do
    acc
  end

  defp rating_value([single_elem], _, _) do
    {int_val, _} = Integer.parse(single_elem, 2)
    int_val
  end

  defp rating_value([head | tail], digit_index, rating_type) do
    list_of_numbers = [head | tail]
    frequencies = calc_frequencies(list_of_numbers)

    rating_fn =
      case rating_type do
        :oxygen -> &Enum.max/1
        :co2 -> &Enum.min/1
      end

    digits_at_index = frequencies |> Enum.at(digit_index)

    digit =
      if length(digits_at_index |> Map.values() |> Enum.uniq()) == 1 do
        case rating_type do
          :oxygen -> "1"
          :co2 -> "0"
        end
      else
        saught_val = digits_at_index |> Map.values() |> rating_fn.()

        digits_at_index
        |> Enum.find(fn {_, val} -> val == saught_val end)
        |> elem(0)
      end

    list_of_numbers
    |> Enum.filter(fn x -> Enum.at(String.graphemes(x), digit_index) == digit end)
    |> rating_value(digit_index + 1, rating_type)
  end
end
