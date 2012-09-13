
defmodule Kvs.Sup do
  use Supervisor.Behavior, []
  def init(_args) do
    {:ok, {{:one_for_one, 
             10, # AllowedRestart(count)
	     100}, # MaxSeconds(sec)
	     []}}
  end
  def connect(super_ref, key) do
    childspec = {key, 
     {Kvs.Srv.Sup, :start_link, [key]},
     :temporary,
      10000,  #shutown wait time(milisec)
      :supervisor,
      [Kvs.Srv.Sup]}
    :supervisor.start_child(super_ref, childspec)
  end
  def quit(super_ref, key) do
    :supervisor.terminate_child(super_ref, key)
  end
end
