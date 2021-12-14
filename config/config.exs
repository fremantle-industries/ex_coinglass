import Config

config :ex_coinglass, api_key: System.get_env("API_KEY")

config :exvcr,
  filter_request_headers: [
    "coinglassSecret"
  ],
  response_headers_blacklist: [
  ]
