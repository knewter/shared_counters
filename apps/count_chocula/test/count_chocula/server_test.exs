defmodule CountChocula.ServerTest do
  use ExUnit.Case
  alias CountChocula.Server

  test "starting the server" do
    assert {:ok, _pid} = Server.start_link()
  end

  test "getting the count" do
    assert {:ok, pid} = Server.start_link()
    assert 0 = Server.get_count(pid)
  end

  test "incrementing" do
    assert {:ok, pid} = Server.start_link()
    :ok = Server.increment(pid)
    assert 1 = Server.get_count(pid)
  end
end
