Code.require_file "../test_helper", __FILE__
defmodule ServerTest do
  use ExUnit.Case
  test "testserver" do
    m = Ekvs.new(:s1, [:public])
    {:ok, _spid} = Kvs.Server.start_link(:s2, m)
    assert nil == :gen_server.call(:s2, {:get, :a})
    assert 1 == :gen_server.call(:s2, {:put, :a, 1})
    assert 2 == :gen_server.call(:s2, {:put, :b, 2})
    assert 2 == :gen_server.call(:s2, {:get, :b})
  end
end
