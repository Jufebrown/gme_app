defmodule GmeAppWeb.ApiController do
  use GmeAppWeb, :controller
  alias GmeApp.Market
  alias GmeApp.Market.AlphaVantage

  def gme(conn, _params) do
    # data = Market.get_recent_quotes()
    data = {data:[2023-10-01, 150.0], [2023-10-02, 155.0], [2023-10-03, 160.0]} # Placeholder for testing

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
