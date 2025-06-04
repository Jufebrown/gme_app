defmodule GmeApp.MarketTest do
  use GmeApp.DataCase

  alias GmeApp.Market

  describe "quotes" do
    alias GmeApp.Market.Quote

    import GmeApp.MarketFixtures

    @invalid_attrs %{close: nil, high: nil, low: nil, open: nil, date: nil, symbol: nil, volume: nil}

    test "list_quotes/0 returns all quotes" do
      quote = quote_fixture()
      assert Market.list_quotes() == [quote]
    end

    test "get_quote!/1 returns the quote with given id" do
      quote = quote_fixture()
      assert Market.get_quote!(quote.id) == quote
    end

    test "create_quote/1 with valid data creates a quote" do
      valid_attrs = %{close: 120.5, high: 120.5, low: 120.5, open: 120.5, date: ~D[2025-06-03], symbol: "some symbol", volume: 42}

      assert {:ok, %Quote{} = quote} = Market.create_quote(valid_attrs)
      assert quote.close == 120.5
      assert quote.high == 120.5
      assert quote.low == 120.5
      assert quote.open == 120.5
      assert quote.date == ~D[2025-06-03]
      assert quote.symbol == "some symbol"
      assert quote.volume == 42
    end

    test "create_quote/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Market.create_quote(@invalid_attrs)
    end

    test "update_quote/2 with valid data updates the quote" do
      quote = quote_fixture()
      update_attrs = %{close: 456.7, high: 456.7, low: 456.7, open: 456.7, date: ~D[2025-06-04], symbol: "some updated symbol", volume: 43}

      assert {:ok, %Quote{} = quote} = Market.update_quote(quote, update_attrs)
      assert quote.close == 456.7
      assert quote.high == 456.7
      assert quote.low == 456.7
      assert quote.open == 456.7
      assert quote.date == ~D[2025-06-04]
      assert quote.symbol == "some updated symbol"
      assert quote.volume == 43
    end

    test "update_quote/2 with invalid data returns error changeset" do
      quote = quote_fixture()
      assert {:error, %Ecto.Changeset{}} = Market.update_quote(quote, @invalid_attrs)
      assert quote == Market.get_quote!(quote.id)
    end

    test "delete_quote/1 deletes the quote" do
      quote = quote_fixture()
      assert {:ok, %Quote{}} = Market.delete_quote(quote)
      assert_raise Ecto.NoResultsError, fn -> Market.get_quote!(quote.id) end
    end

    test "change_quote/1 returns a quote changeset" do
      quote = quote_fixture()
      assert %Ecto.Changeset{} = Market.change_quote(quote)
    end
  end
end
