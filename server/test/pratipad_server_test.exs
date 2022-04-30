defmodule PratipadServerTest do
  use ExUnit.Case
  doctest PratipadServer

  test "greets the world" do
    assert PratipadServer.hello() == :world
  end
end
