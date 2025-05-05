defmodule EPTSDK.RelationshipNotAvailable do
  @moduledoc """
  An value that describes when a relationship for a specified reason.
  """
  @enforce_keys [:name, :reason]
  defstruct [:name, :reason]
  # TODO: What if we could turn this into a request to fill the data?
end
