# ExCoinglass
[![Build Status](https://github.com/fremantle-industries/ex_coinglass/workflows/test/badge.svg?branch=main)](https://github.com/fremantle-industries/ex_coinglass/actions?query=workflow%3Atest)
[![hex.pm version](https://img.shields.io/hexpm/v/ex_coinglass.svg?style=flat)](https://hex.pm/packages/ex_coinglass)

Coinglass API Client for Elixir

## Installation

Add the `ex_coinglass` package to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_coinglass, "~> 0.0.1"}
  ]
end
```

## Requirements

- Erlang 22+
- Elixir 1.11+

## API Documentation

https://coinglass.github.io/API-Reference/#general-info

## REST API

#### Futures

- [x] `GET https://open-api.coinglass.com/api/pro/v1/futures/openInterest`
- [x] `GET https://open-api.coinglass.com/api/pro/v1/futures/openInterest/chart`
- [x] `GET https://open-api.coinglass.com/api/pro/v1/futures/liquidation_chart`
- [x] `GET https://open-api.coinglass.com/api/pro/v1/futures/liquidation/detail/chart`
- [ ] `GET https://open-api.coinglass.com/api/pro/v1/futures/longShort_chart`
- [ ] `GET https://open-api.coinglass.com/api/pro/v1/futures/funding_rates_chart`
- [x] `GET https://open-api.coinglass.com/api/pro/v1/futures/vol/chart`

#### Options

- [x] `GET https://open-api.coinglass.com/api/pro/v1/option/openInterest`
- [x] `GET https://open-api.coinglass.com/api/pro/v1/option/openInterest/history/chart`
- [x] `GET https://open-api.coinglass.com/api/pro/v1/option/vol/history/chart`

## Authors

- Alex Kwiatkowski - alex+git@fremantle.io

## License

`ex_coinglass` is released under the [MIT license](./LICENSE)
