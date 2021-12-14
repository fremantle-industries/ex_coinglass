defmodule ExCoinglass.HTTPClient do
  @type verb :: :get | :post | :put | :delete
  @type params :: map
  @type path :: String.t()
  @type uri :: String.t()
  @type api_key :: String.t()
  @type error_reason :: Maptu.Extension.non_strict_error_reason() | HTTPoison.Error.t()
  @type non_auth_response :: {:ok, ExCoinglass.JsonResponse.t()} | {:error, error_reason}
  @type auth_response :: {:ok, ExCoinglass.JsonResponse.t()} | {:error, error_reason}

  @spec domain :: String.t()
  def domain, do: Application.get_env(:ex_coinglass, :domain, "open-api.coinglass.com")

  @spec protocol :: String.t()
  def protocol, do: Application.get_env(:ex_coinglass, :protocol, "https://")

  @spec origin :: String.t()
  def origin, do: protocol() <> domain()

  @spec url(uri) :: String.t()
  def url(uri), do: origin() <> uri

  @spec api_path :: String.t()
  def api_path, do: Application.get_env(:ex_coinglass, :api_path, "/api/pro")

  @spec non_auth_get(path, params) :: non_auth_response
  def non_auth_get(path, params \\ %{}) do
    non_auth_request(:get, path |> to_uri(params))
  end

  @spec non_auth_request(verb, uri) :: non_auth_response
  def non_auth_request(verb, uri) do
    headers = [] |> put_content_type(:json)

    %HTTPoison.Request{
      method: verb,
      url: url(uri),
      headers: headers
    }
    |> send
  end

  @spec auth_get(path, api_key, params) :: auth_response
  def auth_get(path, api_key, params) do
    auth_request(:get, path |> to_uri(params), api_key, "")
  end

  @spec auth_request(verb, uri, api_key, term) :: auth_response
  def auth_request(verb, uri, api_key, body) do
    headers =
      api_key
      |> auth_headers()
      |> put_content_type(:json)

    %HTTPoison.Request{
      method: verb,
      url: url(uri),
      headers: headers,
      body: body
    }
    |> send
  end

  defp to_uri(path, params) do
    %URI{
      path: api_path() <> path,
      query: URI.encode_query(params)
    }
    |> URI.to_string()
    |> String.trim("?")
  end

  defp put_content_type(headers, :json) do
    Keyword.put(headers, :"Content-Type", "application/json")
  end

  defp send(request) do
    request
    |> HTTPoison.request()
    |> parse_response
  end

  defp auth_headers(api_key) do
    [coinglassSecret: api_key]
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body}}) do
    {:ok, json} = Jason.decode(body)
    Mapail.map_to_struct(json, ExCoinglass.JsonResponse, transformations: [:snake_case])
  end

  defp parse_response({:error, _} = result) do
    result
  end
end
