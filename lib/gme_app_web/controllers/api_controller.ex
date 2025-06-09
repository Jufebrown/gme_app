defmodule GmeAppWeb.ApiController do
  use GmeAppWeb, :controller
  alias GmeApp.Market

  def gme(conn, _params) do
    quotes = Market.get_recent_quotes()

    result =
      Enum.map(quotes, fn %{date: d, close: c} ->
        %{
          time: Date.to_iso8601(d),
          value: c
        }
      end)

    json(conn, result)
  end

  def gme_post(conn, %{"quotes" => quotes}) do
    saved =
      quotes
      |> Enum.map(fn %{"time" => date, "value" => close} ->
        %{date: Date.from_iso8601!(date), close: close}
      end)
      |> GmeApp.Market.insert_quotes()

    json(conn, %{inserted: saved})
  end
end
