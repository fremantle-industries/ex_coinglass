defmodule ExCoinglass.Options.OpenInterestTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExCoinglass.Options.OpenInterest

  setup_all do
    HTTPoison.start()
    :ok
  end

  @valid_api_key System.get_env("API_KEY")
  @invalid_api_key "invalid"

  test ".get/1 ok" do
    use_cassette "options/open_interest/get_ok" do
      assert {:ok, open_interests} = ExCoinglass.Options.OpenInterest.get("BTC", @valid_api_key)
      assert [%ExCoinglass.OptionsOpenInterest{} = open_interest | _] = open_interests
      assert open_interest.h24_change != nil
    end
  end

  test ".get/1 unauthorized" do
    use_cassette "options/open_interest/get_unauthorized" do
      assert ExCoinglass.Options.OpenInterest.get("BTC", @invalid_api_key) == {:error, "secret invalid"}
    end
  end
end
