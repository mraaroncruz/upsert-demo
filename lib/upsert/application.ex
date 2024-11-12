defmodule Upsert.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      UpsertWeb.Telemetry,
      Upsert.Repo,
      {DNSCluster, query: Application.get_env(:upsert, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Upsert.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Upsert.Finch},
      # Start a worker by calling: Upsert.Worker.start_link(arg)
      # {Upsert.Worker, arg},
      # Start to serve requests, typically the last entry
      UpsertWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Upsert.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    UpsertWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
