defmodule ExCoinglass.FuturesOpenInterest do
  @type t :: %__MODULE__{
    exchange_name: String.t(),
    h24_change: number,
    h1_oi_change_percent: number,
    h4_oi_change_percent: number,
    open_interest: number,
    open_interest_amount: number,
    price: number,
    rate: number,
    symbol: String.t(),
    vol_usd: number()
  }

  defstruct ~w[
    exchange_name
    h24_change
    h1_oi_change_percent
    h4_oi_change_percent
    open_interest
    open_interest_amount
    price
    rate
    symbol
    vol_usd
  ]a
end
