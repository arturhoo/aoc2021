defmodule Mix.Tasks.Solve do
  use Mix.Task

  def run(_args) do
    input = File.read!("lib/input7.txt")
    for fun <- [&D7.p1/1, &D7.p2/1], do: fun.(input) |> IO.puts()
  end
end
