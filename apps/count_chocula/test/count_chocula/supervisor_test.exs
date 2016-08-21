defmodule CountChocula.SupervisorTest do
  use ExUnit.Case, async: true
  import TestHelper

  describe "creating new counter" do
    test "creating a nonexistent counter" do
      assert {:ok, _pid} = CountChocula.Supervisor.start_counter(new_id())
    end

    test "creating a counter when one already exists by that name" do
      the_id = new_id()
      assert {:ok, _pid} = CountChocula.Supervisor.start_counter(the_id)
      assert {:ok, _pid} = CountChocula.Supervisor.start_counter(the_id)
    end
  end
end
