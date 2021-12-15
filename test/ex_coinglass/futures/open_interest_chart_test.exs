defmodule ExCoinglass.Futures.OpenInterestChartTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExCoinglass.Futures.OpenInterest

  setup_all do
    HTTPoison.start()
    :ok
  end

  @valid_api_key System.get_env("API_KEY")
  @invalid_api_key "invalid"

  test ".get/1 ok" do
    use_cassette "futures/open_interest_chart/get_ok" do
      assert {:ok, open_interest_chart} = ExCoinglass.Futures.OpenInterestChart.get("BTC", 0, @valid_api_key)
      assert %ExCoinglass.FuturesOpenInterestChart{} = open_interest_chart
      assert open_interest_chart.data_map != nil
    end
  end

  test ".get/1 unauthorized" do
    use_cassette "futures/open_interest_chart/get_unauthorized" do
      assert ExCoinglass.Futures.OpenInterestChart.get("BTC", 0, @invalid_api_key) == {:error, "secret invalid"}
    end
  end
end
