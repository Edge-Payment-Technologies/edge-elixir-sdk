defmodule EPTSDK.WebhookSubscription do
  import EPTSDK.Resource, only: :macros

  @path "/webhook_subscriptions"
  @resource_type "webhook_subscriptions"
  @enforce_keys [
    :id,
    :created_at,
    :updated_at,
    :merchant,
    :__raw__,
    :__links__,
    :__relationships__
  ]
  defstruct [
    :id,
    :type,
    :active,
    :concurrency_limit,
    :description,
    :events,
    :secret_key,
    :url,
    :created_at,
    :updated_at,
    :merchant,
    :__raw__,
    :__links__,
    :__relationships__
  ]

  with_list()
  with_show()
  with_create()
  with_update()
  with_delete()
end
