defmodule MiniTest do
  use ExUnit.Case
  doctest Mini

  test "greets the world" do
    assert Mini.hello() == :world
  end
end
