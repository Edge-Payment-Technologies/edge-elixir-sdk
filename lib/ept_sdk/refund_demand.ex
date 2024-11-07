defmodule EPTSDK.RefundDemand do
  import EPTSDK.Resource, only: :macros

  @path "/refund_demands"
  @resource_type "refund_demands"
  @enforce_keys [
    :id,
    :amount,
    :amount_cents,
    :created_at,
    :updated_at,
    :merchant,
    :payment_demand,
    :__raw__,
    :__links__,
    :__relationships__
  ]
  defstruct [
    :id,
    :type,
    :amount,
    :amount_cents,
    :amount_currency,
    :state,
    :created_at,
    :updated_at,
    :merchant,
    :payment_demand,
    :__raw__,
    :__links__,
    :__relationships__
  ]

  with_list()
  with_show()
  with_create()
end
