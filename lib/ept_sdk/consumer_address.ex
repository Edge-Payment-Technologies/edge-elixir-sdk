defmodule EPTSDK.ConsumerAddress do
  import EPTSDK.Resource, only: :macros

  @path "/consumer_addresses"
  @resource_type "consumer_addresses"
  @enforce_keys [
    :id,
    :line_1,
    :city,
    :state,
    :zip,
    :country,
    :created_at,
    :updated_at,
    :customer,
    :merchant,
    :__raw__,
    :__links__,
    :__relationships__
  ]
  defstruct [
    :id,
    :type,
    :line_1,
    :line_2,
    :city,
    :state,
    :zip,
    :country,
    :created_at,
    :updated_at,
    :customer,
    :merchant,
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
      line_1: EPTSDK.Encoder.fetch(attributes, "line_1"),
      line_2: EPTSDK.Encoder.fetch(attributes, "line_2"),
      city: EPTSDK.Encoder.fetch(attributes, "city"),
      state: EPTSDK.Encoder.fetch(attributes, "state"),
      zip: EPTSDK.Encoder.fetch(attributes, "zip"),
      country: EPTSDK.Encoder.fetch(attributes, "country"),
      created_at: EPTSDK.Encoder.fetch_datetime(attributes, "created_at"),
      updated_at: EPTSDK.Encoder.fetch_datetime(attributes, "updated_at"),
      customer: EPTSDK.Encoder.fetch_relationship(record["relationships"], "customer", included),
      merchant: EPTSDK.Encoder.fetch_relationship(record["relationships"], "merchant", included),
      __relationships__: record["relationships"],
      __links__: record["links"] || links,
      __raw__: record
    }
  end
end
