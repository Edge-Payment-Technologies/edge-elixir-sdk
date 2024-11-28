defmodule EPTSDK.PaymentMethod do
  import EPTSDK.Resource, only: :macros

  @path "/payment_methods"
  @resource_type "payment_methods"
  @enforce_keys [
    :id,
    :card_cvv_token,
    :card_pan_token,
    :expiry_month,
    :expiry_year,
    :created_at,
    :updated_at,
    :merchant,
    :payment_demands,
    :customer,
    :address,
    :__raw__,
    :__links__,
    :__relationships__
  ]
  defstruct [
    :id,
    :type,
    :card_bin,
    :card_cvv_token,
    :card_last_four,
    :card_pan_token,
    :external_state,
    :kind,
    :description,
    :name,
    :expiry_month,
    :expiry_year,
    :discarded_at,
    :created_at,
    :updated_at,
    :merchant,
    :payment_demands,
    :customer,
    :address,
    :__raw__,
    :__links__,
    :__relationships__
  ]

  with_list()
  with_show()
  with_create()
  with_update()
  with_delete()

  def new(id, type, attributes, record, included, links) do
    %__MODULE__{
      id: id,
      type: type,
      card_pan_token: EPTSDK.Encoder.fetch(attributes, "card_pan_token"),
      card_cvv_token: EPTSDK.Encoder.fetch(attributes, "card_cvv_token"),
      expiry_month: EPTSDK.Encoder.fetch(attributes, "expiry_month"),
      expiry_year: EPTSDK.Encoder.fetch(attributes, "expiry_year"),
      card_bin: EPTSDK.Encoder.fetch(attributes, "card_bin"),
      card_last_four: EPTSDK.Encoder.fetch(attributes, "card_last_four"),
      external_state: EPTSDK.Encoder.fetch(attributes, "external_state"),
      kind: EPTSDK.Encoder.fetch(attributes, "kind"),
      discarded_at: EPTSDK.Encoder.fetch_datetime(attributes, "discarded_at"),
      created_at: EPTSDK.Encoder.fetch_datetime(attributes, "created_at"),
      updated_at: EPTSDK.Encoder.fetch_datetime(attributes, "updated_at"),
      merchant: EPTSDK.Encoder.fetch_relationship(record["relationships"], "merchant", included),
      payment_demands:
        EPTSDK.Encoder.fetch_relationship(record["relationships"], "payment_demands", included),
      customer: EPTSDK.Encoder.fetch_relationship(record["relationships"], "customer", included),
      address: EPTSDK.Encoder.fetch_relationship(record["relationships"], "address", included),
      __relationships__: record["relationships"],
      __links__: record["links"] || links,
      __raw__: record
    }
  end
end
