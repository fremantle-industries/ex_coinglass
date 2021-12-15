defmodule ExCoinglass.Futures.LiquidationDetailChartTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExCoinglass.Futures.LiquidationDetailChart

  setup_all do
    HTTPoison.start()
    :ok
  end

  @valid_api_key System.get_env("API_KEY")
  @invalid_api_key "invalid"

  test ".get/1 ok" do
    use_cassette "futures/liquidation_detail_chart/get_ok" do
      assert {:ok, liquidation_detail_charts} = ExCoinglass.Futures.LiquidationDetailChart.get("BTC", "Bitmex", @valid_api_key)
      assert [liquidation_detail_chart | _] = liquidation_detail_charts
      assert %ExCoinglass.FuturesLiquidationDetailChart{} = liquidation_detail_chart
      assert liquidation_detail_chart.turnover_number != nil
    end
  end

  test ".get/1 unauthorized" do
    use_cassette "futures/liquidation_detail_chart/get_unauthorized" do
      assert ExCoinglass.Futures.LiquidationDetailChart.get("BTC", "Bitmex", @invalid_api_key) == {:error, "secret invalid"}
    end
  end
end
