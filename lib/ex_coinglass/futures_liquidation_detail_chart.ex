defmodule ExCoinglass.FuturesLiquidationDetailChart do
  @type t :: %__MODULE__{
    turnover_number: number,
    create_time: non_neg_integer,
    buy_qty: number,
    buy_turnover_number: number,
    buy_vol_usd: number,
    sell_qty: number,
    sell_turnover_number: number,
    sell_vol_usd: number,
    list: list
  }

  defstruct ~w[
    turnover_number
    create_time
    buy_qty
    buy_turnover_number
    buy_vol_usd
    sell_qty
    sell_turnover_number
    sell_vol_usd
    list
  ]a
end
