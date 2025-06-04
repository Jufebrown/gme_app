defmodule GmeApp.Repo.Migrations.CreateQuotes do
  use Ecto.Migration

  def change do
    create table(:quotes) do
      add :symbol, :string
      add :date, :date
      add :open, :float
      add :high, :float
      add :low, :float
      add :close, :float
      add :volume, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
