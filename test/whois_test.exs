defmodule WhoisTest do
  use ExUnit.Case
  doctest Whois

  test "greets the world" do
    assert Whois.hello() == :world
  end
end
