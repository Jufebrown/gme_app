defmodule GmeAppWeb.ApiController do
  use GmeAppWeb, :controller
  alias GmeApp.Market
  alias GmeApp.Market.AlphaVantage

  def gme(conn, _params) do
    data = Market.get_recent_quotes()

    quotes =
      if data == [] do
        fetched = AlphaVantage.fetch_daily_quotes()
        Market.insert_quotes(fetched)
        fetched
      else
        data
      end

    json(conn, Enum.map(quotes, fn %{date: d, close: c} ->
      %{
        time: Date.to_iso8601(d),
        value: c
      }
    end))
  end
end
