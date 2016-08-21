defmodule CountChocula do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(CountChocula.Supervisor, [])
    ]

    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end

  def start_counter(id) do
    case :global.whereis_name(id) do
      :undefined ->
        {:ok, pid} = CountChocula.Supervisor.start_counter
        :yes = :global.register_name(id, pid)
        {:ok, pid}
      pid ->
        {:ok, pid}
    end
  end

  def increment(id) do
    CountChocula.Server.increment({:global, id})
  end

  def get_count(id) do
    CountChocula.Server.get_count({:global, id})
  end
end
