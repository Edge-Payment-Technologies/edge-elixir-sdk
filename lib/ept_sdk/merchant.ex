defmodule EPTSDK.Merchant do
  import EPTSDK.Resource, only: :macros

  @path "/merchants"
  @resource_type "merchants"
  @fields %{
    created_at: :datetime,
    updated_at: :datetime
  }
  @relationships %{
    customers: :many,
    consumer_addresses: :many,
    payment_methods: :many,
    payment_demands: :many,
    events: :many,
    webhook_subscriptions: :many,
    payment_subscriptions: :many
  }

  defresource()

  deflist()
  defshow()
  defupdate()
end
