defmodule ExCoinglass.Futures.VolChartTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExCoinglass.Futures.VolChart

  setup_all do
    HTTPoison.start()
    :ok
  end

  @valid_api_key System.get_env("API_KEY")
  @invalid_api_key "invalid"

  test ".get/1 ok" do
    use_cassette "futures/vol_chart/get_ok" do
      assert {:ok, vol_chart} = ExCoinglass.Futures.VolChart.get("BTC", @valid_api_key)
      assert %ExCoinglass.FuturesVolChart{} = vol_chart
      assert vol_chart.data_map != nil
    end
  end

  test ".get/1 unauthorized" do
    use_cassette "futures/vol_chart/get_unauthorized" do
      assert ExCoinglass.Futures.VolChart.get("BTC", @invalid_api_key) == {:error, "secret invalid"}
    end
  end
end
