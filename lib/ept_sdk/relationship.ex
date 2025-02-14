defmodule EPTSDK.Relationship do
  @enforce_keys [:name, :has]
  defstruct [:name, :data, :has]
  # TODO: What if we could turn this into a request to fill the data?
end
