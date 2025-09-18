defmodule EPTSDK.ConsumerAddress do
  import EPTSDK.Resource, only: :macros

  @path "/consumer_addresses"
  @resource_type "consumer_addresses"
  @fields %{
    line_1: :string,
    line_2: :string,
    city: :string,
    state: :string,
    zip: :string,
    country: :string,
    created_at: :datetime,
    updated_at: :datetime
  }
  @relationships %{merchant: :one, customer: :one}

  defresource()
  deflist()
  defshow()
  defcreate()
  defupdate()
  defdelete()
end
