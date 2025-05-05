defmodule EPTSDK.PropertyNotAvailable do
  @moduledoc """
  A value that describes when a property isn't available from the HTTP API for the specified reason.
  """
  @enforce_keys [:name, :reason]
  defstruct [:name, :reason]
  # TODO: What if we could turn this into a request to fill the data?
end
