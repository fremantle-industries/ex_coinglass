defmodule ExCoinglass.Futures.VolChart do
  alias ExCoinglass.JsonResponse

  @type symbol :: String.t()
  @type api_key :: String.t()
  @type futures_open_interest :: ExCoinglass.FuturesVolChart.t()
  @type result :: {:ok, futures_open_interest} | {:error, JsonResponse.msg() | :parse_result_item}

  @spec get(symbol, api_key) :: result
  def get(symbol, api_key) do
    "/v1/futures/vol/chart"
    |> ExCoinglass.HTTPClient.auth_get(api_key, %{symbol: symbol})
    |> parse_response()
  end

  defp parse_response({:ok, %JsonResponse{success: true, data: open_interest_chart}}) do
    open_interest_chart
    |> Mapail.map_to_struct(ExCoinglass.FuturesVolChart, transformations: [:snake_case])
    |> case do
      {:ok, _} = result -> result
      _ -> {:error, :parse_result_item}
    end
  end

  defp parse_response({:ok, %JsonResponse{success: false, msg: msg}}) do
    {:error, msg}
  end
end
