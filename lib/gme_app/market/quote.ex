defmodule GmeApp.Market.Quote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quotes" do
    field :date, :date
    field :close, :float
    timestamps()
  end

  def changeset(quote, attrs) do
    quote
    |> cast(attrs, [:date, :close])
    |> validate_required([:date, :close])
    |> unique_constraint(:date)
  end
end
