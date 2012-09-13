Code.require_file "../test_helper", __FILE__
defmodule ServerSupTest do
  use ExUnit.Case
  test "testserver_sup" do
    Kvs.Srv.Sup.start_link(:s4)
    assert :lists.member(:s4, :lists.map(fn(e) -> :proplists.get_value(:name, :ets.info(e)) end, :ets.all()))
    tid = :proplists.get_value(:s4, :lists.map(fn(e) -> {:proplists.get_value(:name, :ets.info(e)), e} end, :ets.all()))
    assert :proplists.get_value(:name, :ets.info(tid) ) == :s4
    assert nil == :gen_server.call(:s4, {:get, :a})
    assert 1 == :gen_server.call(:s4, {:put, :a, 1})
    assert 2 == :gen_server.call(:s4, {:put, :b, 2})
    assert 2 == :gen_server.call(:s4, {:get, :b})
  end
end
