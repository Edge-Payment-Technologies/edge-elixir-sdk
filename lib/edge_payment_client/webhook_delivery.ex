defmodule EdgePaymentClient.WebhookDelivery do
  import EdgePaymentClient.Resource, only: :macros

  @path "/webhook_deliveries"
  @resource_type "webhook_deliveries"
  @enforce_keys [
    :id,
    :created_at,
    :updated_at,
    :__raw__,
    :__links__,
    :__relationships__
  ]
  defstruct [:id,
            :type,
            :created_at,
            :updated_at,
            :__raw__,
            :__links__,
            :__relationships__]

  with_list()
  with_show()
end
