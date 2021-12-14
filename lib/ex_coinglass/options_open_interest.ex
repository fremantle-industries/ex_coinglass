defmodule ExCoinglass.OptionsOpenInterest do
  @type t :: %__MODULE__{
    exchange_name: String.t(),
    exchange_logo: String.t(),
    open_interest: number,
    open_interest_amount: number,
    h24_change: number,
    rate: number
  }

  defstruct ~w[
    exchange_name
    exchange_logo
    open_interest
    open_interest_amount
    h24_change
    rate
  ]a
end
