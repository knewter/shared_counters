defmodule Web.CounterChannel do
  use Web.Web, :channel

  def join("counter:"<>id, _payload, socket) do
    {:ok, _pid} = CountChocula.start_counter(id)
    send(self, :push_state)
    {:ok, socket}
  end

  def handle_info(:push_state, socket) do
    push socket, "counter:state", %{ count: CountChocula.get_count(counter_id(socket.topic)) }
    {:noreply, socket}
  end

  def handle_in("counter:increment", _, socket) do
    :ok = counter_id(socket.topic) |> CountChocula.increment()
    {:reply, :ok, socket}
  end

  defp counter_id(topic_string) do
    topic_string |> String.split(":") |> Enum.drop(1) |> hd
  end
end
