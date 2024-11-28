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

  def new(id, type, attributes, record, included, links) do
    %__MODULE__{
      id: id,
      type: type,
      amount: EPTSDK.Encoder.fetch_money(attributes, ["amount_cents", "amount_currency"]),
      amount_cents: EPTSDK.Encoder.fetch(attributes, "amount_cents"),
      amount_currency: EPTSDK.Encoder.fetch(attributes, "amount_currency"),
      state: EPTSDK.Encoder.fetch(attributes, "state"),
      created_at: EPTSDK.Encoder.fetch_datetime(attributes, "created_at"),
      updated_at: EPTSDK.Encoder.fetch_datetime(attributes, "updated_at"),
      payment_demand:
        EPTSDK.Encoder.fetch_relationship(record["relationships"], "payment_demand", included),
      merchant: EPTSDK.Encoder.fetch_relationship(record["relationships"], "merchant", included),
      __relationships__: record["relationships"],
      __links__: record["links"] || links,
      __raw__: record
    }
  end
end
