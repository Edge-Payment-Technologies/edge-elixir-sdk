defmodule EPTSDK.PaymentDemand do
  import EPTSDK.Resource, only: :macros

  @path "/payment_demands"
  @resource_type "payment_demands"
  @enforce_keys [
    :id,
    :amount,
    :amount_cents,
    :amount_currency,
    :net,
    :net_cents,
    :fee,
    :fee_cents,
    :created_at,
    :updated_at,
    :merchant,
    :buyer,
    :receiver,
    :payer,
    :payment_method,
    :billing_address,
    :payment_subscription,
    :shipping_address,
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
    :net,
    :net_cents,
    :fee,
    :fee_cents,
    :description,
    :idempotency_key,
    :processor_state,
    :created_at,
    :updated_at,
    :merchant,
    :buyer,
    :receiver,
    :payer,
    :payment_method,
    :billing_address,
    :refund_demands,
    :payment_subscription,
    :shipping_address,
    :__raw__,
    :__links__,
    :__relationships__
  ]

  with_list()
  with_show()
  with_create()
  with_update()
end
