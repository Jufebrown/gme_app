defmodule GmeAppWeb.QuoteController do
  use GmeAppWeb, :controller
  alias GmeApp.Market
  alias GmeApp.Market.Quote

  def index(conn, _params) do
    symbol = "GME"

    # Try to get a recent quote from the database
    case Market.get_recent_quote(symbol) do
      nil ->
        entries = Market.fetch_from_alpha_vantage(symbol)
        json(conn, entries)

      _quote ->
        quotes = Market.get_all_quotes(symbol)
        json(conn, quotes)
    end
  end
end
