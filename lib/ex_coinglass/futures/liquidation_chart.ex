defmodule ExCoinglass.Futures.LiquidationChart do
  alias ExCoinglass.JsonResponse

  @type symbol :: String.t()
  @type ex_name :: String.t()
  @type api_key :: String.t()
  @type futures_open_interest :: ExCoinglass.FuturesLiquidationChart.t()
  @type result :: {:ok, futures_open_interest} | {:error, JsonResponse.msg() | :parse_result_item}

  @spec get(symbol, ex_name, api_key) :: result
  def get(symbol, ex_name, api_key) do
    "/v1/futures/liquidation_chart"
    |> ExCoinglass.HTTPClient.auth_get(api_key, %{symbol: symbol, exName: ex_name})
    |> parse_response()
  end

  defp parse_response({:ok, %JsonResponse{success: true, data: liquidation_chart}}) do
    liquidation_chart
    |> Mapail.map_to_struct(ExCoinglass.FuturesLiquidationChart, transformations: [:snake_case])
    |> case do
      {:ok, _} = result -> result
      _ -> {:error, :parse_result_item}
    end
  end

  defp parse_response({:ok, %JsonResponse{success: false, msg: msg}}) do
    {:error, msg}
  end
end
