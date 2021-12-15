defmodule ExCoinglass.FuturesLiquidationChart do
  @type t :: %__MODULE__{
    buy_list: list,
    buy_qty: non_neg_integer,
    sell_list: list,
    sell_qty: non_neg_integer,
    date_list: list,
    num_list: list,
    price_list: list,
  }

  defstruct ~w[
    buy_list
    buy_qty
    sell_list
    sell_qty
    date_list
    num_list
    price_list
  ]a
end
