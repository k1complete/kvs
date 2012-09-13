defmodule Kvs.Srv.Sup do
  use Supervisor.Behavior, []
  def init(args) do
    key = args
    tbl_id = :ets.new(key, [:public])
    childspec = {key, 
      {Kvs.Server, :start_link, [key, tbl_id]},
       :permanent, 
       100000,
       :worker, 
       [Kvs.Server]}
     {:ok, {{:one_for_one, 
       10, # AllowedRestart(count)
       100}, # MaxSeconds(sec)
       [childspec]}}
  end
end
