defmodule GmeApp.MarketFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GmeApp.Market` context.
  """

  @doc """
  Generate a quote.
  """
  def quote_fixture(attrs \\ %{}) do
    {:ok, quote} =
      attrs
      |> Enum.into(%{
        close: 120.5,
        date: ~D[2025-06-03],
        high: 120.5,
        low: 120.5,
        open: 120.5,
        symbol: "some symbol",
        volume: 42
      })
      |> GmeApp.Market.create_quote()

    quote
  end
end
