defmodule ExCoinglass.Futures.FundingRatesChart do
  alias ExCoinglass.JsonResponse

  @type symbol :: String.t()
  @type interval :: non_neg_integer
  @type api_key :: String.t()
  @type futures_funding_rate_chart :: ExCoinglass.FuturesFundingRatesChart.t()
  @type result :: {:ok, [futures_funding_rate_chart]} | {:error, JsonResponse.msg() | :parse_result_item}

  @spec get(symbol, interval, api_key) :: result
  def get(symbol, interval, api_key) do
    "/v1/futures/funding_rates_chart"
    |> ExCoinglass.HTTPClient.auth_get(api_key, %{symbol: symbol, interval: interval})
    |> parse_response()
  end

  defp parse_response({:ok, %JsonResponse{success: true, data: futures_funding_rate_chart}}) do
    futures_funding_rate_chart
    |> Mapail.map_to_struct(ExCoinglass.FuturesFundingRatesChart, transformations: [:snake_case])
    |> case do
      {:ok, _} = result -> result
      _ -> {:error, :parse_result_item}
    end
  end

  defp parse_response({:ok, %JsonResponse{success: false, msg: msg}}) do
    {:error, msg}
  end
end
