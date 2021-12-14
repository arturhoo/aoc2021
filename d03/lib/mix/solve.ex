defmodule Mix.Tasks.Solve do
  use Mix.Task

  def run(_args) do
    input = File.read!("lib/input3.txt")
    for fun <- [&D3.p1/1, &D3.p2/1], do: fun.(input) |> IO.puts()
  end
end
