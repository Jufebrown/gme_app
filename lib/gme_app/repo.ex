defmodule GmeApp.Repo do
  use Ecto.Repo,
    otp_app: :gme_app,
    adapter: Ecto.Adapters.Postgres
end
