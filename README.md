a simple key value store otp application for elixir sample

feature:
- on memory kvs.
- robust (auto restart on crash, but keep table).
- multi client.

require:
 elixir-0.6.0 or later
building:
 $ mix compile

running:
 $ mix iex

running demo:

iex(1)> :application.start(:sasl)

=PROGRESS REPORT==== 13-Sep-2012::23:51:09 ===
          supervisor: {local,sasl_safe_sup}
             started: [{pid,<0.47.0>},
                       {name,alarm_handler},
                       {mfargs,{alarm_handler,start_link,[]}},
                       {restart_type,permanent},
                       {shutdown,2000},
                       {child_type,worker}]

=PROGRESS REPORT==== 13-Sep-2012::23:51:09 ===
          supervisor: {local,sasl_safe_sup}
             started: [{pid,<0.48.0>},
                       {name,overload},
                       {mfargs,{overload,start_link,[]}},
                       {restart_type,permanent},
                       {shutdown,2000},
                       {child_type,worker}]

=PROGRESS REPORT==== 13-Sep-2012::23:51:09 ===
          supervisor: {local,sasl_sup}
             started: [{pid,<0.46.0>},
                       {name,sasl_safe_sup},
                       {mfargs,
                           {supervisor,start_link,
                               [{local,sasl_safe_sup},sasl,safe]}},
                       {restart_type,permanent},
                       {shutdown,infinity},
                       {child_type,supervisor}]

=PROGRESS REPORT==== 13-Sep-2012::23:51:09 ===
          supervisor: {local,sasl_sup}
             started: [{pid,<0.49.0>},
                       {name,release_handler},
                       {mfargs,{release_handler,start_link,[]}},
                       {restart_type,permanent},
                       {shutdown,2000},
                       {child_type,worker}]

=PROGRESS REPORT==== 13-Sep-2012::23:51:09 ===
         application: sasl
          started_at: nonode@nohost
:ok
iex(2)> :application.start(:kvs) 
:ok
iex(3)> 
=PROGRESS REPORT==== 13-Sep-2012::23:51:13 ===
         application: kvs
          started_at: nonode@nohost

nil
iex(4)> Kvs.Sup.connect(:kvs_sup, :c1)

=INFO REPORT==== 13-Sep-2012::23:52:56 ===
Kvs.Server started:
8211

=PROGRESS REPORT==== 13-Sep-2012::23:52:56 ===
          supervisor: {<0.55.0>,'Elixir-Kvs-Srv-Sup'}
             started: [{pid,<0.56.0>},
                       {name,c1},
                       {mfargs,{'Elixir-Kvs-Server',start_link,[c1,8211]}},
                       {restart_type,permanent},
                       {shutdown,100000},
                       {child_type,worker}]

=PROGRESS REPORT==== 13-Sep-2012::23:52:56 ===
          supervisor: {local,kvs_sup}
             started: [{pid,<0.55.0>},
                       {name,c1},
                       {mfargs,{'Elixir-Kvs-Srv-Sup',start_link,[c1]}},
                       {restart_type,temporary},
                       {shutdown,10000},
                       {child_type,supervisor}]
{:ok,<0.55.0>}
iex(5)> :gen_server.call(:c1, {:put, :a, :b})
:b
iex(6)> :gen_server.call(:c1, {:put, :a2, :b2})
:b2
iex(7)> :gen_server.call(:c1, {:put, :a3, :b4})
:b4
iex(8)> :gen_server.call(:c1, {:get, :a2})     
:b2
iex(9)> :gen_server.call(:c1, {:get, :a1})
nil
iex(10)> :gen_server.call(:c1, {:get, :a}) 
:b
iex(11)> :gen_server.call(:c1, {:keys})       
[:a3,:a2,:a]
iex(12)> :gen_server.call(:c1, {:badrequest})

=ERROR REPORT==== 13-Sep-2012::23:54:20 ===
Kvs.Server crashed:
{:function_clause,[{Kvs.Server,:handle_call,[{:badrequest},{<0.41.0>,#Ref<0.0.0.220>},8211],[{:file,'/Users/k-1/work/erl/elixir_doc/proj/kvs/lib/kvs_server.ex'},{:line,10}]},{:gen_server,:handle_msg,5,[{:file,'gen_server.erl'},{:line,588}]},{:proc_lib,:init_p_do_apply,3,[{:file,'proc_lib.erl'},{:line,227}]}]}

=ERROR REPORT==== 13-Sep-2012::23:54:20 ===
Kvs.Server snapshot:
8211

=ERROR REPORT==== 13-Sep-2012::23:54:20 ===
** Generic server c1 terminating 
** Last message in was {badrequest}
** When Server state == 8211
** Reason for termination == 
** {function_clause,
       [{'Elixir-Kvs-Server',handle_call,
            [{badrequest},{<0.41.0>,#Ref<0.0.0.220>},8211],
            [{file,
                 "/Users/k-1/work/erl/elixir_doc/proj/kvs/lib/kvs_server.ex"},
             {line,10}]},
        {gen_server,handle_msg,5,[{file,"gen_server.erl"},{line,588}]},
        {proc_lib,init_p_do_apply,3,[{file,"proc_lib.erl"},{line,227}]}]}
** (exit) {{:function_clause,[{Kvs.Server,:handle_call,[{:badrequest},{<0.41.0>,#Ref<0.0.0.220>},8211],[{:file,'/Users/k-1/work/erl/elixir_doc/proj/kvs/lib/kvs_server.ex'},{:line,10}]},{:gen_server,:handle_msg,5,[{:file,'gen_server.erl'},{:line,588}]},{:proc_lib,:init_p_do_apply,3,[{:file,'proc_lib.erl'},{:line,227}]}]},{:gen_server,:call,[:c1,{:badrequest}]}}

=CRASH REPORT==== 13-Sep-2012::23:54:20 ===
  crasher:
    initial call: Elixir-Kvs-Server:init/1
    pid: <0.56.0>
    registered_name: c1
    exception exit: {function_clause,
                        [{'Elixir-Kvs-Server',handle_call,
                             [{badrequest},{<0.41.0>,#Ref<0.0.0.220>},8211],
                             [{file,
                                  "/Users/k-1/work/erl/elixir_doc/proj/kvs/lib/kvs_server.ex"},
                              {line,10}]},
                         {gen_server,handle_msg,5,
                             [{file,"gen_server.erl"},{line,588}]},
                         {proc_lib,init_p_do_apply,3,
                             [{file,"proc_lib.erl"},{line,227}]}]}
      in function  gen_server:terminate/6 (gen_server.erl, line 747)
    ancestors: [<0.55.0>,kvs_sup,<0.53.0>]
    messages: []
    links: [<0.55.0>]
    dictionary: []
    trap_exit: false
    status: running
    heap_size: 4181
    stack_size: 24
    reductions: 3318
  neighbours:

=SUPERVISOR REPORT==== 13-Sep-2012::23:54:20 ===
     Supervisor: {<0.55.0>,'Elixir-Kvs-Srv-Sup'}
     Context:    child_terminated
     Reason:     {function_clause,
                     [{'Elixir-Kvs-Server',handle_call,
                          [{badrequest},{<0.41.0>,#Ref<0.0.0.220>},8211],
                          [{file,
                               "/Users/k-1/work/erl/elixir_doc/proj/kvs/lib/kvs_server.ex"},
                           {line,10}]},
                      {gen_server,handle_msg,5,
                          [{file,"gen_server.erl"},{line,588}]},
                      {proc_lib,init_p_do_apply,3,
                          [{file,"proc_lib.erl"},{line,227}]}]}
     Offender:   [{pid,<0.56.0>},
                  {name,c1},
                  {mfargs,{'Elixir-Kvs-Server',start_link,[c1,8211]}},
                  {restart_type,permanent},
                  {shutdown,100000},
                  {child_type,worker}]


=INFO REPORT==== 13-Sep-2012::23:54:20 ===
Kvs.Server started:
8211

=PROGRESS REPORT==== 13-Sep-2012::23:54:20 ===
          supervisor: {<0.55.0>,'Elixir-Kvs-Srv-Sup'}
             started: [{pid,<0.57.0>},
                       {name,c1},
                       {mfargs,{'Elixir-Kvs-Server',start_link,[c1,8211]}},
                       {restart_type,permanent},
                       {shutdown,100000},
                       {child_type,worker}]
    Binary.Inspect.Kvs.Server.inspect({Kvs.Server,:handle_call,[{:badrequest},{<0.41.0>,#Ref<0.0.0.220>},8211],[{:file,'/Users/k-1/work/erl/elixir_doc/proj/kvs/lib/kvs_server.ex'},{:line,10}]})
    /Users/k-1/work/erl/elixir_doc/material/elixir/lib/elixir/lib/binary/inspect.ex:15: Binary.Inspect.inspect/1
    /Users/k-1/work/erl/elixir_doc/material/elixir/lib/elixir/lib/binary/inspect.ex:174: Binary.Inspect.List.container_join/3
    /Users/k-1/work/erl/elixir_doc/material/elixir/lib/elixir/lib/binary/inspect.ex:170: Binary.Inspect.List.container_join/3
    /Users/k-1/work/erl/elixir_doc/material/elixir/lib/elixir/lib/binary/inspect.ex:174: Binary.Inspect.List.container_join/3
    /Users/k-1/work/erl/elixir_doc/material/elixir/lib/elixir/lib/iex.ex:172: IEx.do_loop/1

iex(12)> :gen_server.call(:c1, {:keys})      
[:a3,:a2,:a]
iex(14)> Kvs.Sup.connect(:kvs_sup, :c2)
{:ok,<0.58.0>}
iex(15)> 
=INFO REPORT==== 13-Sep-2012::23:56:14 ===
Kvs.Server started:
12306

=PROGRESS REPORT==== 13-Sep-2012::23:56:14 ===
          supervisor: {<0.58.0>,'Elixir-Kvs-Srv-Sup'}
             started: [{pid,<0.59.0>},
                       {name,c2},
                       {mfargs,{'Elixir-Kvs-Server',start_link,[c2,12306]}},
                       {restart_type,permanent},
                       {shutdown,100000},
                       {child_type,worker}]

=PROGRESS REPORT==== 13-Sep-2012::23:56:14 ===
          supervisor: {local,kvs_sup}
             started: [{pid,<0.58.0>},
                       {name,c2},
                       {mfargs,{'Elixir-Kvs-Srv-Sup',start_link,[c2]}},
                       {restart_type,temporary},
                       {shutdown,10000},
                       {child_type,supervisor}]

nil
iex(16)> :gen_server.call(:c2, {:get, :a})
nil
iex(17)> :gen_server.call(:c1, {:get, :a})
:b
