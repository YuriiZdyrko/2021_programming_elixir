defmodule ProgrammingElixirTest do
  use ExUnit.Case
  doctest ProgrammingElixir

  test "greets the world" do
    assert ProgrammingElixir.hello() == :world
  end
end
