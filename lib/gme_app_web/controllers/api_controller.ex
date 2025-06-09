defmodule GmeAppWeb.ApiController do
  use GmeAppWeb, :controller

  def gme(conn, _params) do
    quotes = GmeApp.Market.get_all_quotes()

    result =
      Enum.map(quotes, fn quote ->
        %{
          time: Date.to_iso8601(quote.date),
          open: quote.open,
          high: quote.high,
          low: quote.low,
          close: quote.close,
          volume: quote.volume
        }
      end)

    json(conn, result)
  end

  def gme_post(conn, %{"quotes" => quotes}) do
    saved =
      quotes
      |> Enum.map(fn %{
                      "time" => date,
                      "open" => open,
                      "high" => high,
                      "low" => low,
                      "close" => close,
                      "volume" => volume
                    } ->
        %{
          date: Date.from_iso8601!(date),
          open: open,
          high: high,
          low: low,
          close: close,
          volume: volume
        }
      end)
      |> GmeApp.Market.insert_quotes()

    json(conn, %{status: "ok"})
  end
end
