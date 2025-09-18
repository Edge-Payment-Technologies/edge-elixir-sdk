defmodule EPTSDK.RefundDemand do
  import EPTSDK.Resource, only: :macros

  @path "/refund_demands"
  @resource_type "refund_demands"
  @fields %{
    amount: {:money, cents: :amount_cents, currency: :amount_currency},
    amount_cents: :integer,
    amount_currency: {:enum, values: [:USD]},
    state: {:enum, values: [:pending, :processing, :succeeded, :failed]},
    created_at: :datetime,
    processing_at: :datetime,
    succeeded_at: :datetime,
    failed_at: :datetime,
    updated_at: :datetime
  }
  @relationships %{
    processor_detail: :one,
    payment_demand: :one,
    merchant: :one,
    payment_method: :one
  }

  defresource()

  deflist()
  defshow()
  defcreate()
end
