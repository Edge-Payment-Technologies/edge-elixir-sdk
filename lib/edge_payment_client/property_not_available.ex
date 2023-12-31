defmodule EdgePaymentClient.PropertyNotAvailable do
  @enforce_keys [:property]
  defstruct [:property]
  @type t() :: %__MODULE__{property: String.t()}
  # TODO: What if we could turn this into a request to fill the data?
end
