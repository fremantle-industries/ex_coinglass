defmodule ExCoinglass.JsonResponse do
  @type msg :: String.t()
  @type t :: %__MODULE__{
    code: String.t(),
    msg: msg,
    success: boolean,
    data: list | map
  }

  defstruct ~w[code msg success data]a
end
