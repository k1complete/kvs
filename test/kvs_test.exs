Code.require_file "../test_helper", __FILE__
defmodule EkvsTest do
  use ExUnit.Case
  test "testekvsdict" do
    m = Ekvs.new(:id)
    assert [] == Ekvs.keys(m)
    assert nil = Ekvs.get(m, :a)
    m2 = Ekvs.put(m, :a, :b)
    assert m2 ==  m
    assert :b == Ekvs.get(m, :a)
  end
  test "bulkinsert-delete" do
    m = Ekvs.new(:id)
    :lists.map(fn(x) -> Ekvs.put(m, "key-#{x}", x) end, :lists.seq(1,1000))
    r = :lists.map(fn(x) -> Ekvs.get(m, "key-#{x}") end, :lists.seq(1,1000))
    assert r == :lists.seq(1,1000)
    :lists.map(fn(x) -> Ekvs.delete(m, "key-#{x}") end, :lists.seq(1, 1000))
    assert Ekvs.keys(m) == []
  end
end
