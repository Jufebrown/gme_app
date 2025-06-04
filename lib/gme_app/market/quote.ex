defmodule GmeApp.Market.Quote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quotes" do
    field :close, :float
    field :high, :float
    field :low, :float
    field :open, :float
    field :date, :date
    field :symbol, :string
    field :volume, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(quote, attrs) do
    quote
    |> cast(attrs, [:symbol, :date, :open, :high, :low, :close, :volume])
    |> validate_required([:symbol, :date, :open, :high, :low, :close, :volume])
  end
end
