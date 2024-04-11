defmodule PublicDomains do
  use GenServer, restart: :transient
  require Logger

  @cache_key {__MODULE__, :domain_list}

  #
  # Client
  #

  @doc """
  Check whether the given domain hosts publicly-available email

  The domain should be given as a domain only, for example `example.com`. Strings are
  automatically downcased and trimmed for whitespace or leading `@` characters, but full email
  addresses (such as `me@example.com`) are not supported.

  Domains are checked for exact matches only. Subdomains (for example `sub.example.com`) will not
  be listed as public if only the higher-level domain (`example.com`) is included in the list. If
  a subdomain also hosts publicly-available email, please contribute it back to the
  community-maintained list.
  """
  @spec public?(String.t()) :: boolean
  def public?(domain) do
    domain =
      domain
      |> String.downcase()
      |> String.trim()
      |> String.trim_leading("@")

    :persistent_term.get(@cache_key)
    |> MapSet.member?(domain)
  end

  @doc false
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  #
  # Server
  #

  @doc false
  @impl true
  def init(_opts) do
    {:ok, nil, {:continue, :load}}
  end

  @doc false
  @impl true
  def handle_continue(:load, state) do
    Logger.debug("[PublicDomains] Caching list of public domains")
    cache_domain_list()
    {:stop, :normal, state}
  end

  #
  # Internal
  #

  @doc false
  @spec cache_domain_list :: :ok
  def cache_domain_list do
    :persistent_term.put(@cache_key, read_domain_list())
  end

  @doc false
  @spec read_domain_list :: MapSet.t(String.t())
  def read_domain_list do
    :code.priv_dir(:public_domains)
    |> Path.join("domains.txt")
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> MapSet.new()
  end
end
