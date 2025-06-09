defmodule GmeApp.Market do
  import Ecto.Query, warn: false
  alias GmeApp.Repo
  alias GmeApp.Market.Quote

  def get_all_quotes do
    from(q in Quote, order_by: [asc: q.date])
    |> Repo.all()
  end

  def insert_quotes(quotes) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    entries =
      Enum.map(quotes, fn q ->
        %{
          date: q.date,
          open: q.open * 1.00,
          high: q.high * 1.00,
          low: q.low * 1.00,
          close: q.close * 1.00,
          volume: q.volume,
          inserted_at: now,
          updated_at: now
        }
      end)

    Repo.insert_all(Quote, entries, on_conflict: :nothing, conflict_target: :date)
  end
end
