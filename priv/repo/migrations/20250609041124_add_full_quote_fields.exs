defmodule GmeApp.Repo.Migrations.AddFullQuoteFields do
  use Ecto.Migration

  def change do
    alter table(:quotes) do
      add :open, :float
      add :high, :float
      add :low, :float
      add :volume, :integer
    end
  end
end
