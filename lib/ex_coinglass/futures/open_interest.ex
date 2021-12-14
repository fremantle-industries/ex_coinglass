defmodule ExCoinglass.Futures.OpenInterest do
  alias ExCoinglass.JsonResponse

  @type symbol :: String.t()
  @type api_key :: String.t()
  @type futures_open_interest :: ExCoinglass.OptionsOpenInterest.t()
  @type result :: {:ok, [futures_open_interest]} | {:error, JsonResponse.msg(), :parse_result_item}

  @spec get(symbol, api_key) :: result
  def get(symbol, api_key) do
    "/v1/futures/openInterest"
    |> ExCoinglass.HTTPClient.auth_get(api_key, %{symbol: symbol})
    |> parse_response()
  end

  defp parse_response({:ok, %JsonResponse{success: true, data: open_interest}}) do
    open_interest
    |> Enum.map(&Mapail.map_to_struct(&1, ExCoinglass.FuturesOpenInterest, transformations: [:snake_case]))
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
