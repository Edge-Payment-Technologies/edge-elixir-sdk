defmodule EPTSDK.RelationshipEmpty do
  @enforce_keys [:name]
  defstruct [:name]
  # TODO: What if we could turn this into a request to fill the data?
end
