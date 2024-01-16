defmodule EPTSDK.RelationshipNotAvailable do
  @enforce_keys [:name, :reason]
  defstruct [:name, :reason]
  # TODO: What if we could turn this into a request to fill the data?
end
