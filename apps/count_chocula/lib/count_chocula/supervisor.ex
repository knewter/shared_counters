defmodule CountChocula.Supervisor do
  use Supervisor
  @name CountChoculaSupervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: @name)
  end

  def start_counter do
    Supervisor.start_child(@name, [])
  end

  def init(_) do
    children = [
      worker(CountChocula.Server, [], restart: :transient)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
