defmodule GmeApp.Market.AlphaVantage do
  @symbol "GME"
  @api_key System.get_env("ALPHA_VANTAGE_API_KEY")
  @url "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{@symbol}&apikey=#{@api_key}"

  def fetch_daily_quotes do
  IO.puts("Calling Alpha Vantage...")
  IO.puts(@url)

  case HTTPoison.get(@url) do
    {:ok, %{body: body}} ->
      IO.puts("Got response")
      case Jason.decode(body) do
        {:ok, decoded} ->
          IO.inspect(decoded, label: "Decoded JSON")

          case Map.get(decoded, "Time Series (Daily)") do
            nil -> 
              IO.puts("Missing time series data")
              []
            ts ->
              Enum.map(ts, fn {date, data} ->
                %{
                  date: Date.from_iso8601!(date),
                  close: String.to_float(data["4. close"])
                }
              end)
          end

        {:error, err} ->
          IO.inspect(err, label: "JSON Decode Error")
          []
      end

    {:error, err} ->
      IO.inspect(err, label: "HTTP Error")
      []
  end

  end
end
