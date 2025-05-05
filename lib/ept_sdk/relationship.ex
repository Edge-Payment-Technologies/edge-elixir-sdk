defmodule EPTSDK.Relationship do
  @moduledoc """
  A value that represents a resource's relationship, used to either fetch that related data or
  as a placeholder for included data.
  """
  @enforce_keys [:name, :has]
  defstruct [:name, :data, :has]
  # TODO: What if we could turn this into a request to fill the data?
end
