defmodule ExCoinglass.Futures.LongShortChart do
  alias ExCoinglass.JsonResponse

  @type symbol :: String.t()
  @type interval :: non_neg_integer
  @type api_key :: String.t()
  @type futures_liquidation_detail_chart :: ExCoinglass.FuturesLongShortChart.t()
  @type result :: {:ok, [futures_liquidation_detail_chart]} | {:error, JsonResponse.msg() | :parse_result_item}

  @spec get(symbol, interval, api_key) :: result
  def get(symbol, interval, api_key) do
    "/v1/futures/longShort_chart"
    |> ExCoinglass.HTTPClient.auth_get(api_key, %{symbol: symbol, interval: interval})
    |> parse_response()
  end

  defp parse_response({:ok, %JsonResponse{success: true, data: long_short_chart}}) do
    long_short_chart
    |> Mapail.map_to_struct(ExCoinglass.FuturesLongShortChart, transformations: [:snake_case])
    |> case do
      {:ok, _} = result -> result
      _ -> {:error, :parse_result_item}
    end
  end

  defp parse_response({:ok, %JsonResponse{success: false, msg: msg}}) do
    {:error, msg}
  end
end
