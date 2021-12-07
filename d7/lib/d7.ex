defmodule D7 do
  def p1(input) do
    nums =
      String.split(input)
      |> Enum.at(0)
      |> String.split(",")
      |> Enum.map(fn i -> elem(Integer.parse(i), 0) end)

    median = median(nums)

    Enum.map(nums, fn i -> abs(i - median) end)
    |> Enum.sum()
  end

  defp median(list_of_nums) do
    len = length(list_of_nums)
    sorted = Enum.sort(list_of_nums)
    mid = div(len, 2)

    if rem(len, 2) == 0 do
      div(Enum.at(sorted, mid - 1) + Enum.at(sorted, mid), 2)
    else
      Enum.at(sorted, mid)
    end
  end

  def p2(_input) do
    nil
  end
end
