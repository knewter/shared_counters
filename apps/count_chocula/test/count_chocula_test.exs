defmodule CountChoculaTest do
  use ExUnit.Case
  import TestHelper

  test "starting a new counter" do
    assert {:ok, _pid} = CountChocula.start_counter(new_id())
  end
end
