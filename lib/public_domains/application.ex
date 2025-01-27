defmodule PublicDomains.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = [PublicDomains]

    opts = [strategy: :one_for_one, name: PublicDomains.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
