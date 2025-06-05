defmodule GmeApp.Market.AlphaVantage do
  @symbol "GME"
  @api_key System.get_env("ALPHA_VANTAGE_API_KEY")
  @url "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{@symbol}&apikey=#{@api_key}"

  def fetch_daily_quotes do
    case HTTPoison.get(@url) do
      {:ok, %{body: body}} ->
        body
        |> Jason.decode!()
        |> Map.get("Time Series (Daily)", %{})
        |> Enum.map(fn {date, data} ->
          %{
            date: Date.from_iso8601!(date),
            close: String.to_float(data["4. close"])
          }
        end)

      _ -> []
    end
  end
end
