defmodule EPTSDK.PaymentDemand do
  import EPTSDK.Resource, only: :macros

  @path "/payment_demands"
  @resource_type "payment_demands"
  @enforce_keys [
    :id,
    :amount,
    :amount_cents,
    :net,
    :net_cents,
    :fee,
    :fee_cents,
    :refund,
    :refund_cents,
    :gateway,
    :gateway_cents,
    :currency,
    :created_at,
    :updated_at,
    :merchant,
    :customer,
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
    :net,
    :net_cents,
    :fee,
    :fee_cents,
    :refund,
    :refund_cents,
    :gateway,
    :gateway_cents,
    :currency,
    :description,
    :created_at,
    :updated_at,
    :merchant,
    :customer,
    :payment_method,
    :billing_address,
    :payment_subscription,
    :shipping_address,
    :__raw__,
    :__links__,
    :__relationships__
  ]

  with_list()
  with_show()
  with_create()
end
