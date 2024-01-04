defmodule EPTSDK.PropertyNotAvailable do
  @enforce_keys [:property, :reason]
  defstruct [:property, :reason]
  # TODO: What if we could turn this into a request to fill the data?
end
