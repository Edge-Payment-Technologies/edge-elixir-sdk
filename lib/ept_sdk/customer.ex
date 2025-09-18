defmodule EPTSDK.Customer do
  import EPTSDK.Resource, only: :macros

  @path "/customers"
  @resource_type "customers"

  @fields %{
    name: :string,
    email: :string,
    phone_number: :string,
    description: :string,
    blocked_at: :datetime,
    created_at: :datetime,
    updated_at: :datetime
  }
  @relationships %{
    addresses: :many,
    verified_payment_methods: :many,
    merchant: :one,
    payment_demands: :many
  }

  defresource()
  deflist()
  defshow()
  defcreate()
  defupdate()
  defdelete()
end
