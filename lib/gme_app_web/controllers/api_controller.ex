defmodule GmeAppWeb.ApiController do
  use GmeAppWeb, :controller
  alias GmeApp.Market
  alias GmeApp.Market.AlphaVantage

  def gme(conn, _params) do
    IO.puts("Fetching from DB...")
    data = Market.get_recent_quotes()

    quotes =
      if data == [] do
        IO.puts("No data in DB. Fetching from Alpha Vantage...")
        fetched = AlphaVantage.fetch_daily_quotes()
        IO.inspect(fetched, label: "Fetched quotes")
        Market.insert_quotes(fetched)
        fetched
      else
        IO.inspect(data, label: "DB data")
        data
      end

    result =
      Enum.map(quotes, fn %{date: d, close: c} ->
        %{
          time: Date.to_iso8601(d),
          value: c
        }
      end)

    IO.inspect(result, label: "Final result")

    json(conn, result)
  end
end
