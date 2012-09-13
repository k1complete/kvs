defmodule Ekvs do
  def new(id) do
    new(id, [])
  end
  def new(id, opts) do
    :ets.new(id, opts)
  end
  def put(id, k, v) do
    true = :ets.insert(id, {k, v})
    id
  end
  def get(id, k) do
    case :ets.lookup(id, k) do
      [] -> nil
      [{^k, v}] -> v
    end
  end
  defp keys(_id, :"$end_of_table", a) do
    a
  end
  defp keys(id, r, a) do
    keys(id, :ets.next(id, r), [r | a])
  end
  def keys(id) do
    keys(id, :ets.first(id), [])
  end
  def delete(id, k) do
    :ets.delete(id, k)
    id
  end
end
