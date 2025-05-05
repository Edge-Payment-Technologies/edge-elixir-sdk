defmodule EPTSDK.RelationshipEmpty do
  @moduledoc """
  Represents a value for when the API is saying that there's no data for the relationship.
  """
  @enforce_keys [:name]
  defstruct [:name]
  # TODO: What if we could turn this into a request to fill the data?
end
