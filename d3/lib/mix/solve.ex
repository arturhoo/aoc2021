defmodule Mix.Tasks.Solve do
  use Mix.Task

  def run(_args) do
    File.read!("lib/input3.txt")
    |> D3.p1()
    |> IO.puts()
  end
end
