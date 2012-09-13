defmodule Application.Behavior do
  defmacro __using__(_) do
    quote do
      @behaviour :application
      def start(_type, _args) do
	{:error, :not_impelement_yet}
      end
      def stop(_state) do
	:ok
      end
      defoverridable [start: 2, stop: 1]
    end
  end
end
