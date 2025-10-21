defmodule PooblikLibraery.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PooblikLibraeryWeb.Telemetry,
      PooblikLibraery.Repo,
      {DNSCluster, query: Application.get_env(:pooblik_libraery, :dns_cluster_query) || :ignore},
      {Oban,
       AshOban.config(
         Application.fetch_env!(:pooblik_libraery, :ash_domains),
         Application.fetch_env!(:pooblik_libraery, Oban)
       )},
      {Phoenix.PubSub, name: PooblikLibraery.PubSub},
      # Start a worker by calling: PooblikLibraery.Worker.start_link(arg)
      # {PooblikLibraery.Worker, arg},
      # Start to serve requests, typically the last entry
      PooblikLibraeryWeb.Endpoint,
      {AshAuthentication.Supervisor, [otp_app: :pooblik_libraery]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PooblikLibraery.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PooblikLibraeryWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
