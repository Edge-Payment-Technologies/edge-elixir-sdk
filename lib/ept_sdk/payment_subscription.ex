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
    :__links__
  ]
  defstruct [
    :id,
    :type,
    :amount,
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
    :__links__
  ]

  with_list()
  with_show()
  with_create()
  with_delete()

  def new(id, type, attributes, record, links) do
    %__MODULE__{
      id: id,
      type: type,
      amount: EPTSDK.Encoder.fetch(attributes, ["amount_cents", "amount_currency"], :money),
      amount_cents: EPTSDK.Encoder.fetch(attributes, "amount_cents"),
      amount_currency: EPTSDK.Encoder.fetch(attributes, "amount_currency"),
      billing_period: EPTSDK.Encoder.fetch(attributes, "billing_period"),
      description: EPTSDK.Encoder.fetch(attributes, "description"),
      next_billing_day: EPTSDK.Encoder.fetch(attributes, "next_billing_day"),
      status: EPTSDK.Encoder.fetch(attributes, "status"),
      next_billing: EPTSDK.Encoder.fetch_datetime(attributes, "next_billing"),
      discarded_at: EPTSDK.Encoder.fetch_datetime(attributes, "discarded_at"),
      end_at: EPTSDK.Encoder.fetch_datetime(attributes, "end_at"),
      created_at: EPTSDK.Encoder.fetch_datetime(attributes, "created_at"),
      updated_at: EPTSDK.Encoder.fetch_datetime(attributes, "updated_at"),
      merchant: EPTSDK.Encoder.fetch_relationship(record["relationships"], "merchant"),
      payment_demands:
        EPTSDK.Encoder.fetch_relationship(record["relationships"], "payment_demands"),
      payment_method:
        EPTSDK.Encoder.fetch_relationship(record["relationships"], "payment_method"),
      customer: EPTSDK.Encoder.fetch_relationship(record["relationships"], "customer"),
      # TODO: turn into formal links structs
      __links__: record["links"] || links,
      __raw__: record
    }
  end
end
