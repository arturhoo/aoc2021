defmodule Mix.Tasks.Solve do
  use Mix.Task

  def run(_args) do
    input = File.read!("lib/input14.txt")
    for fun <- [&D14.p1/1, &D14.p2/1], do: fun.(input) |> IO.puts()
  end
end
