defmodule EPTSDK.Relationship do
  @enforce_keys [:name, :id, :type]
  defstruct [:name, :id, :type]
  # TODO: What if we could turn this into a request to fill the data?
end
