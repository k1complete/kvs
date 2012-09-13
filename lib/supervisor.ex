defmodule Supervisor.Behavior do
  defmacro __using__(_args) do
    quote do
      @behaviour :supervisor
      def start_link(name, arg) do
	:supervisor.start_link({:local, name}, __MODULE__, arg)
      end
      def start_link(arg) do
	:supervisor.start_link(__MODULE__, arg)
      end
      def init(_args) do
	{:error, :not_implement_yet}
      end
      def check_childspecs(m) do
	:supervisor.check_childspecs(m)
      end
      defoverridable [start_link: 2, start_link: 1, init: 1]
    end
  end
  import ExUnit.Assertions
  def check_supervisorspec({restart_strategy, allow_restarts, maxseconds}) do
    assert restart_strategy in 
     [:one_for_one, :one_for_all, :rest_for_one, :simple_one_for_one]
    assert is_number(allow_restarts), 
     "#{inspect allow_restarts} should be restart number in maxseconds seconds"
    assert is_number(maxseconds), 
     "#{inspect maxseconds} should be seconds in allow_restarts times"
  end
end
