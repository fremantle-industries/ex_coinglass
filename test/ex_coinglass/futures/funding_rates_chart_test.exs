defmodule ExCoinglass.Futures.FundingRatesChartTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExCoinglass.Futures.FundingRatesChart

  setup_all do
    HTTPoison.start()
    :ok
  end

  @valid_api_key System.get_env("API_KEY")
  @invalid_api_key "invalid"

  test ".get/1 ok" do
    use_cassette "futures/funding_rates_chart/get_ok" do
      assert {:ok, funding_rates_chart} = ExCoinglass.Futures.FundingRatesChart.get("BTC", 2, @valid_api_key)
      assert %ExCoinglass.FuturesFundingRatesChart{} = funding_rates_chart
      assert funding_rates_chart.data_map != nil
    end
  end

  test ".get/1 unauthorized" do
    use_cassette "futures/funding_rates_chart/get_unauthorized" do
      assert ExCoinglass.Futures.LongShortChart.get("BTC", 2, @invalid_api_key) == {:error, "secret invalid"}
    end
  end
end
