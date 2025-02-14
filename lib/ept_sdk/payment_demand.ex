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

  def new(id, type, attributes, record, links) do
    %__MODULE__{
      id: id,
      type: type,
      amount: EPTSDK.Encoder.fetch_money(attributes, ["amount_cents", "amount_currency"]),
      amount_cents: EPTSDK.Encoder.fetch(attributes, "amount_cents"),
      amount_currency: EPTSDK.Encoder.fetch(attributes, "amount_currency"),
      fee: EPTSDK.Encoder.fetch_money(attributes, ["fee_cents", "amount_currency"]),
      fee_cents: EPTSDK.Encoder.fetch(attributes, "fee_cents"),
      net: EPTSDK.Encoder.fetch_money(attributes, ["net_cents", "amount_currency"]),
      net_cents: EPTSDK.Encoder.fetch(attributes, "net_cents"),
      idempotency_key: EPTSDK.Encoder.fetch(attributes, "idempotency_key"),
      description: EPTSDK.Encoder.fetch(attributes, "description"),
      created_at: EPTSDK.Encoder.fetch_datetime(attributes, "created_at"),
      updated_at: EPTSDK.Encoder.fetch_datetime(attributes, "updated_at"),
      buyer: EPTSDK.Encoder.fetch_relationship(record["relationships"], "buyer"),
      receiver: EPTSDK.Encoder.fetch_relationship(record["relationships"], "receiver"),
      payer: EPTSDK.Encoder.fetch_relationship(record["relationships"], "payer"),
      payment_method:
        EPTSDK.Encoder.fetch_relationship(record["relationships"], "payment_method"),
      billing_address:
        EPTSDK.Encoder.fetch_relationship(record["relationships"], "billing_address"),
      payment_subscription:
        EPTSDK.Encoder.fetch_relationship(
          record["relationships"],
          "payment_subscription"
        ),
      refund_demands:
        EPTSDK.Encoder.fetch_relationship(record["relationships"], "refund_demands"),
      shipping_address:
        EPTSDK.Encoder.fetch_relationship(record["relationships"], "shipping_address"),
      merchant: EPTSDK.Encoder.fetch_relationship(record["relationships"], "merchant"),
      __relationships__: record["relationships"],
      __links__: record["links"] || links,
      __raw__: record
    }
  end
end
