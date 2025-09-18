defmodule EPTSDK.PaymentSubscriptions do
  import EPTSDK.Resource, only: :macros

  @path "/payment_subscriptions"
  @resource_type "payment_subscriptions"
  @fields %{
    description: :string,
    amount: {:money, cents: :amount_cents, currency: :amount_currency},
    amount_cents: :integer,
    amount_currency: {:enum, values: [:USD]},
    slug: :string,
    status: {:enum, values: [:incomplete, :ready, :active, :cancelled, :paused]},
    current_period_start_at: :datetime,
    current_period_end_at: :datetime,
    total_collected: {:money, cents: :total_collected, currency: :amount_currency},
    payer_timezone: :string,
    purchase_kind: {:enum, values: [:order, :invoice]},
    purchase_reference: :string,
    trial_end_at: :datetime,
    proration_behavior: {:enum, values: [:none, :create_proration]},
    billing_cycle_anchor_at: :datetime,
    billing_period:
      {:enum,
       values: [
         :one_day,
         :seven_days,
         :fourteen_days,
         :thirty_days,
         :one_month,
         :six_months,
         :twelve_months
       ]},
    line_items: {:array, :map},
    shipping_detail: :map,
    tax_detail: :map,
    metadata: :map,
    billing_scheme: {:enum, values: [:per_unit]},
    next_billing_at: :datetime,
    discarded_at: :datetime,
    end_at: :datetime,
    canceled_at: :datetime,
    created_at: :datetime,
    updated_at: :datetime
  }
  @relationships %{
    processor_detail: :one,
    fee_plan: :one,
    merchant_token: :one,
    merchant_integration: :one,
    merchant: :one,
    payment_demands: :many,
    payment_method: :one,
    payer: :one,
    receiver: :one,
    buyer: :one,
    billing_address: :one,
    shipping_address: :one
  }

  defresource()

  deflist()
  defshow()
  defcreate()
  defdelete()
end
