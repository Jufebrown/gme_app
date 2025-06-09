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
end
