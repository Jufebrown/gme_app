defmodule GmeApp.Market do
  import Ecto.Query
  alias GmeApp.Repo
  alias GmeApp.Market.Quote

  @trading_days_ago 1

  def get_recent_quotes do
    cutoff_date = Date.add(Date.utc_today(), -@trading_days_ago)

    from(q in Quote,
      where: q.date >= ^cutoff_date
    )
    |> Repo.all()
  end
  
  def get_all_quotes(symbol) do
    from(q in Quote, where: q.symbol == ^symbol, order_by: q.date)
    |> Repo.all()
  end

  def fetch_from_alpha_vantage(symbol) do
    api_key = System.get_env("ALPHA_VANTAGE_API_KEY")
    url = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{symbol}&apikey=#{api_key}"

    with {:ok, %HTTPoison.Response{body: body, status_code: 200}} <- HTTPoison.get(url),
         {:ok, decoded} <- Jason.decode(body),
         %{"Time Series (Daily)" => series} <- decoded do

      entries =
        series
        |> Enum.map(fn {date, data} ->
          %{
            symbol: symbol,
            date: Date.from_iso8601!(date),
            open: String.to_float(data["1. open"]),
            high: String.to_float(data["2. high"]),
            low: String.to_float(data["3. low"]),
            close: String.to_float(data["4. close"]),
            volume: String.to_integer(data["5. volume"])
          }
        end)

      Repo.insert_all(Quote, entries, on_conflict: :nothing)
      entries
    else
      _ -> []
    end
  end
end
