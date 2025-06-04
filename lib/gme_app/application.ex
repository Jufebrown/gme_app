defmodule GmeApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GmeAppWeb.Telemetry,
      GmeApp.Repo,
      {DNSCluster, query: Application.get_env(:gme_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: GmeApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: GmeApp.Finch},
      # Start a worker by calling: GmeApp.Worker.start_link(arg)
      # {GmeApp.Worker, arg},
      # Start to serve requests, typically the last entry
      GmeAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GmeApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GmeAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
