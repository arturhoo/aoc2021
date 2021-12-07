defmodule D7 do
  def p1(input) do
    positions = parse_input(input)
    median = median(positions)

    positions
    |> Enum.map(&abs(&1 - median))
    |> Enum.sum()
  end

  def p2(input) do
    positions = parse_input(input)
    avg_position = avg(positions)

    [&trunc/1, &round/1]
    |> Enum.map(fn fun -> calc_p2_fuel(positions, avg_position, fun) end)
    |> Enum.min()
  end

  defp parse_input(input) do
    String.split(input)
    |> Enum.at(0)
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  defp median(numbers) do
    len = length(numbers)
    sorted = Enum.sort(numbers)
    mid = div(len, 2)

    if rem(len, 2) == 0 do
      div(Enum.at(sorted, mid - 1) + Enum.at(sorted, mid), 2)
    else
      Enum.at(sorted, mid)
    end
  end

  defp avg(numbers) do
    Enum.sum(numbers) / length(numbers)
  end

  defp calc_p2_fuel(positions, target_pos, fun) do
    positions
    |> Enum.map(&triangular_number(abs(&1 - fun.(target_pos))))
    |> Enum.sum()
  end

  # https://en.wikipedia.org/wiki/Triangular_number
  defp triangular_number(num) do
    div(Integer.pow(num, 2) + num, 2)
  end
end
