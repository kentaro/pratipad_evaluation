defmodule PratipadExampleTest do
  use ExUnit.Case
  doctest Pratipad.Example

  test "greets the world" do
    assert Pratipad.Example.hello() == :world
  end
end
