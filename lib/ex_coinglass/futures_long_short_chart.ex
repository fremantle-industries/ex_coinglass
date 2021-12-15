defmodule ExCoinglass.FuturesLongShortChart do
  @type t :: %__MODULE__{
    buy_qty: number,
    sell_qty: number,
    date_list: list,
    long_rate_list: list,
    shorts_rate_list: list,
    long_short_rate_list: list,
    price_list: list,
    symbol: String.t(),
    time_type: non_neg_integer
  }

  defstruct ~w[
    buy_qty
    sell_qty
    date_list
    long_rate_list
    shorts_rate_list
    long_short_rate_list
    price_list
    symbol
    time_type
  ]a
end
