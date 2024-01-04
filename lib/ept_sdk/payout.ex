defmodule EPTSDK.Payout do
  import EPTSDK.Resource, only: :macros

  @path "/payouts"
  @resource_type "payouts"
  @enforce_keys [
    :id,
    :created_at,
    :updated_at,
    :__raw__,
    :__links__,
    :__relationships__
  ]
  defstruct [
    :id,
    :type,
    :amount_cents,
    :amount_currency,
    :fee_cents,
    :fee_currency,
    :net_amount_cents,
    :net_amount_currency,
    :processor_state,
    :transfer_credit_type,
    :created_at,
    :updated_at,
    :__raw__,
    :__links__,
    :__relationships__
  ]

  with_list()
  with_show()
  with_create()
end
