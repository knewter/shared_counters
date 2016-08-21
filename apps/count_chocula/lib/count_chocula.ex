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

  defdelegate start_counter(id), to: CountChocula.Supervisor
end
