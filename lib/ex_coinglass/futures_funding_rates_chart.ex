defmodule ExCoinglass.FuturesFundingRatesChart do
  @type t :: %__MODULE__{
    data_map: map,
    date_list: list,
    fr_data_map: map,
    price_list: list
  }

  defstruct ~w[
    data_map
    date_list
    fr_data_map
    price_list
  ]a
end
