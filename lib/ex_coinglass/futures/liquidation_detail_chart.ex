defmodule ExCoinglass.Futures.LiquidationDetailChart do
  alias ExCoinglass.JsonResponse

  @type symbol :: String.t()
  @type ex_name :: String.t()
  @type api_key :: String.t()
  @type futures_liquidation_detail_chart :: ExCoinglass.FuturesLiquidationDetailChart.t()
  @type result :: {:ok, [futures_liquidation_detail_chart]} | {:error, JsonResponse.msg() | :parse_result_item}

  @spec get(symbol, ex_name, api_key) :: result
  def get(symbol, ex_name, api_key) do
    "/v1/futures/liquidation/detail/chart"
    |> ExCoinglass.HTTPClient.auth_get(api_key, %{symbol: symbol, exName: ex_name})
    |> parse_response()
  end

  defp parse_response({:ok, %JsonResponse{success: true, data: liquidation_detail_chart}}) do
    liquidation_detail_chart
    |> Enum.map(&Mapail.map_to_struct(&1, ExCoinglass.FuturesLiquidationDetailChart, transformations: [:snake_case]))
    |> Enum.reduce(
      {:ok, []},
      fn
        {:ok, i}, {:ok, acc} -> {:ok, [i | acc]}
        _, _acc -> {:error, :parse_result_item}
      end
    )
  end

  defp parse_response({:ok, %JsonResponse{success: false, msg: msg}}) do
    {:error, msg}
  end
end
