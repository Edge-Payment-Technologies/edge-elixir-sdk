defmodule EPTSDK.PaymentSubscriptions do
  import EPTSDK.Resource, only: :macros

  @path "/payment_subscriptions"
  @resource_type "payment_subscriptions"
  @enforce_keys [
    :id,
    :created_at,
    :updated_at,
    :merchant,
    :payment_demands,
    :customer,
    :payment_method,
    :__raw__,
    :__links__,
    :__relationships__
  ]
  defstruct [
    :id,
    :type,
    :amount_cents,
    :amount_currency,
    :billing_period,
    :description,
    :next_billing_day,
    :status,
    :discarded_at,
    :end_at,
    :next_billing,
    :created_at,
    :updated_at,
    :merchant,
    :payment_demands,
    :customer,
    :payment_method,
    :__raw__,
    :__links__,
    :__relationships__
  ]

  with_list()
  with_show()
  with_create()
  with_delete()
end
