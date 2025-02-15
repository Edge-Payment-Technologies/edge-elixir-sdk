defmodule EPTSDK.Customer do
  import EPTSDK.Resource, only: :macros

  @path "/customers"
  @resource_type "customers"
  @enforce_keys [
    :id,
    :name,
    :email,
    :created_at,
    :updated_at,
    :addresses,
    :payment_methods,
    :payment_demands,
    :merchant,
    :__raw__,
    :__links__
  ]
  defstruct [
    :id,
    :type,
    :name,
    :email,
    :phone_number,
    :discarded_at,
    :blocked_at,
    :created_at,
    :updated_at,
    :addresses,
    :payment_methods,
    :payment_demands,
    :merchant,
    :__raw__,
    :__links__
  ]

  with_list()
  with_show()
  with_create()
  with_update()
  with_delete()

  def new(id, type, attributes, record, links) do
    %__MODULE__{
      id: id,
      type: type,
      name: EPTSDK.Encoder.fetch(attributes, "name"),
      email: EPTSDK.Encoder.fetch(attributes, "email"),
      phone_number: EPTSDK.Encoder.fetch(attributes, "phone_number"),
      discarded_at: EPTSDK.Encoder.fetch(attributes, "discarded_at"),
      blocked_at: EPTSDK.Encoder.fetch_datetime(attributes, "blocked_at"),
      created_at: EPTSDK.Encoder.fetch_datetime(attributes, "created_at"),
      updated_at: EPTSDK.Encoder.fetch_datetime(attributes, "updated_at"),
      addresses: EPTSDK.Encoder.fetch_relationship(record["relationships"], "addresses"),
      payment_methods:
        EPTSDK.Encoder.fetch_relationship(record["relationships"], "payment_methods"),
      merchant: EPTSDK.Encoder.fetch_relationship(record["relationships"], "merchant"),
      payment_demands:
        EPTSDK.Encoder.fetch_relationship(record["relationships"], "payment_demands"),
      # TODO: turn into formal links structs
      __links__: record["links"] || links,
      __raw__: record
    }
  end
end
