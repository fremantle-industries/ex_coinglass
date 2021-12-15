defmodule ExCoinglass.Options.VolHistoryChartTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExCoinglass.Options.VolHistoryChart

  setup_all do
    HTTPoison.start()
    :ok
  end

  @valid_api_key System.get_env("API_KEY")
  @invalid_api_key "invalid"

  test ".get/1 ok" do
    use_cassette "options/vol_history_chart/get_ok" do
      assert {:ok, vol_history_chart} = ExCoinglass.Options.VolHistoryChart.get("BTC", @valid_api_key)
      assert %ExCoinglass.OptionsVolHistoryChart{} = vol_history_chart
      assert vol_history_chart.data_map != nil
    end
  end

  test ".get/1 unauthorized" do
    use_cassette "options/vol_history_chart/get_unauthorized" do
      assert ExCoinglass.Options.VolHistoryChart.get("BTC", @invalid_api_key) == {:error, "secret invalid"}
    end
  end
end
