defmodule GmeApp.Market do
  import Ecto.Query, warn: false
  alias GmeApp.Repo
  alias GmeApp.Market.Quote

  @trading_days_ago 260

  def get_recent_quotes do
    cutoff = Date.add(Date.utc_today(), -@trading_days_ago)

    Repo.all(
      from q in Quote,
      where: q.date >= ^cutoff,
      order_by: [asc: q.date]
    )
  end

  def insert_quotes(quotes) do
    Enum.each(quotes, fn %{date: date, close: close} ->
      %Quote{}
      |> Quote.changeset(%{date: date, close: close})
      |> Repo.insert(on_conflict: :nothing)
    end)

    IO.puts("Inserted #{length(quotes)} quotes")
  end

end
