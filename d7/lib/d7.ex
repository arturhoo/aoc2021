defmodule D7 do
  def p1(input) do
    nums = parse_input(input)
    median = median(nums)

    nums
    |> Enum.map(&abs(&1 - median))
    |> Enum.sum()
  end

  def p2(input) do
    nums = parse_input(input)
    avg = avg(nums)

    cost1 =
      nums
      |> Enum.map(&triangular_number(abs(&1 - trunc(avg))))
      |> Enum.sum()

    cost2 =
      nums
      |> Enum.map(&triangular_number(abs(&1 - round(avg))))
      |> Enum.sum()

    if cost1 < cost2 do
      cost1
    else
      cost2
    end
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

  @doc """
  https://en.wikipedia.org/wiki/Triangular_number
  """
  defp triangular_number(num) do
    div(Integer.pow(num, 2) + num, 2)
  end
end
