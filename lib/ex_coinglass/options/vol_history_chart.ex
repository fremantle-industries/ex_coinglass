defmodule ExCoinglass.Options.VolHistoryChart do
  alias ExCoinglass.JsonResponse

  @type symbol :: String.t()
  @type api_key :: String.t()
  @type options_open_interest :: ExCoinglass.OptionsVolHistoryChart.t()
  @type result :: {:ok, options_open_interest} | {:error, JsonResponse.msg() | :parse_result_item}

  @spec get(symbol, api_key) :: result
  def get(symbol, api_key) do
    "/v1/option/vol/history/chart"
    |> ExCoinglass.HTTPClient.auth_get(api_key, %{symbol: symbol})
    |> parse_response()
  end

  defp parse_response({:ok, %JsonResponse{success: true, data: vol_history_chart}}) do
    vol_history_chart
    |> Mapail.map_to_struct(ExCoinglass.OptionsVolHistoryChart, transformations: [:snake_case])
    |> case do
      {:ok, _} = result -> result
      _ -> {:error, :parse_result_item}
    end
  end

  defp parse_response({:ok, %JsonResponse{success: false, msg: msg}}) do
    {:error, msg}
  end
end
