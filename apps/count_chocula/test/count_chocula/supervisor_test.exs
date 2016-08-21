defmodule CountChocula.SupervisorTest do
  use ExUnit.Case, async: true

  test "creating new counter" do
    assert {:ok, _pid} = CountChocula.Supervisor.start_counter()
  end
end
