defmodule ExCoinglass.Futures.OpenInterestTest do
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
    use_cassette "futures/open_interest/get_ok" do
      assert {:ok, open_interests} = ExCoinglass.Futures.OpenInterest.get("BTC", @valid_api_key)
      assert [%ExCoinglass.FuturesOpenInterest{} = open_interest | _] = open_interests
      assert open_interest.h1_oi_change_percent != nil
    end
  end

  test ".get/1 unauthorized" do
    use_cassette "futures/open_interest/get_unauthorized" do
      assert ExCoinglass.Futures.OpenInterest.get("BTC", @invalid_api_key) == {:error, "secret invalid"}
    end
  end
end
