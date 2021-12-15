defmodule ExCoinglass.Futures.LiquidationChartTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExCoinglass.Futures.LiquidationChart

  setup_all do
    HTTPoison.start()
    :ok
  end

  @valid_api_key System.get_env("API_KEY")
  @invalid_api_key "invalid"

  test ".get/1 ok" do
    use_cassette "futures/liquidation_chart/get_ok" do
      assert {:ok, liquidation_chart} = ExCoinglass.Futures.LiquidationChart.get("BTC", "Bitmex", @valid_api_key)
      assert %ExCoinglass.FuturesLiquidationChart{} = liquidation_chart
      assert liquidation_chart.buy_list != nil
    end
  end

  test ".get/1 unauthorized" do
    use_cassette "futures/liquidation_chart/get_unauthorized" do
      assert ExCoinglass.Futures.LiquidationChart.get("BTC", "Bitmex", @invalid_api_key) == {:error, "secret invalid"}
    end
  end
end
