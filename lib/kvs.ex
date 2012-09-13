#
defmodule KvsApp do
  @behaviour :application
  def start() do
    :ok = :application.start(:kvs)
  end
  def start(_type, args) do
    Kvs.Sup.start_link(:kvs_sup, args)
  end
  def stop() do
    :application.stop(:kvs)
  end
  def stop(state) do
    Kvs.Sup.stop(:application_stop, state)
  end
end
