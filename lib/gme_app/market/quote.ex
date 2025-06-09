defmodule GmeApp.Market.Quote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quotes" do
    field :date, :date
    field :open, :float
    field :high, :float
    field :low, :float
    field :close, :float
    field :volume, :integer

    timestamps()
  end

  @required ~w(date open high low close)a

  def changeset(quote, attrs) do
    quote
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
