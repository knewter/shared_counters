defmodule CountChocula.Server do
  use GenServer

  ### Public API
  def start_link(id) do
    case GenServer.start_link(__MODULE__, [], name: {:global, id}) do
      {:ok, pid} -> {:ok, pid}
      {:error, {:already_started, pid}} -> {:ok, pid}
    end
  end

  def get_count(pid) do
    GenServer.call(pid, :get_count)
  end

  def increment(pid) do
    GenServer.cast(pid, :increment)
  end

  ### Server API
  def init(_) do
    {:ok, 0}
  end

  def handle_call(:get_count, _from, state) do
    {:reply, state, state}
  end

  def handle_cast(:increment, state) do
    {:noreply, state+1}
  end
end
