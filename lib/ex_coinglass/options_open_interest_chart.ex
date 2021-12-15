defmodule ExCoinglass.OptionsOpenInterestChart do
  @type t :: %__MODULE__{
    data_map: map,
    date_list: list,
    price_list: list
  }

  defstruct ~w[data_map date_list price_list]a
end
