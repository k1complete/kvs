defmodule Kvs.Server do
  use GenServer.Behavior
  def start_link(id, tbl_id) do
    :gen_server.start_link({:local, id}, __MODULE__, [id, tbl_id], [])
  end
  def init([_id, tbl_id]) do
    :error_logger.info_report('#{inspect __MODULE__} started:\n#{tbl_id}')
    {:ok, tbl_id}
  end
  def handle_call({:get, key}, _from, state) do
    {:reply, Ekvs.get(state, key), state}
  end
  def handle_call({:put, key, value}, _from, state) do
    {:reply, value, Ekvs.put(state, key, value)}
  end
  def handle_call({:delete, key}, _from, state) do
    {:reply, :ok, Ekvs.delete(state, key)}
  end
  def handle_call({:keys}, _from, state) do
    {:reply, Ekvs.keys(state), state}
  end
  def terminate(reason, state) do
    :error_logger.error_report('#{inspect __MODULE__} crashed:\n#{inspect reason}')
    :error_logger.error_report('#{inspect __MODULE__} snapshot:\n#{inspect state}')
    :ok
  end
end
