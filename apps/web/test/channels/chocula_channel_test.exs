defmodule Web.CounterChannelTest do
  use Web.ChannelCase
  alias Web.CounterChannel
  import TestHelper

  describe "interacting with a counter" do
    setup [:join_counter_channel]

    test "starts the counter on join", %{id: id} do
      assert is_pid(:global.whereis_name(id))
    end

    test "sends the counter's state on join" do
      assert_push "counter:state", %{count: 0}
    end

    test "incrementing the counter", %{id: id, socket: socket} do
      assert 0 = get_count(id)
      ref = push socket, "counter:increment", %{}
      assert_reply ref, :ok
      assert 1 = get_count(id)
      assert_broadcast "counter:state", %{count: 1}
    end
  end

  defp join_counter_channel(_) do
    id = new_id()
    {:ok, _, socket} =
      socket("user_id", %{})
      |> subscribe_and_join(CounterChannel, "counter:#{id}")

    {:ok, socket: socket, id: id}
  end

  defp get_count(id) do
    CountChocula.Server.get_count({:global, id})
  end
end
