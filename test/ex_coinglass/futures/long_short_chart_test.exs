defmodule ExCoinglass.Futures.LongShortChartTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExCoinglass.Futures.LongShortChart

  setup_all do
    HTTPoison.start()
    :ok
  end

  @valid_api_key System.get_env("API_KEY")
  @invalid_api_key "invalid"

  test ".get/1 ok" do
    use_cassette "futures/long_short_chart/get_ok" do
      assert {:ok, long_short_chart} = ExCoinglass.Futures.LongShortChart.get("BTC", 2, @valid_api_key)
      assert %ExCoinglass.FuturesLongShortChart{} = long_short_chart
      assert long_short_chart.long_short_rate_list != nil
    end
  end

  test ".get/1 unauthorized" do
    use_cassette "futures/long_short_chart/get_unauthorized" do
      assert ExCoinglass.Futures.LongShortChart.get("BTC", 2, @invalid_api_key) == {:error, "secret invalid"}
    end
  end
end
