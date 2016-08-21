defmodule CountChoculaTest do
  use ExUnit.Case
  import TestHelper

  test "starting a new counter" do
    assert {:ok, _pid} = CountChocula.start_counter(new_id())
  end

  test "starting a counter when one already exists by that name" do
    the_id = new_id()
    assert {:ok, pid} = CountChocula.start_counter(the_id)
    assert {:ok, ^pid} = CountChocula.start_counter(the_id)
  end

  test "incrementing a counter by id string" do
    id = new_id()
    {:ok, _pid} = id |> CountChocula.start_counter()
    :ok = id |> CountChocula.increment()
    assert 1 = CountChocula.get_count(id)
  end
end
