defmodule EPTSDK.Event do
  import EPTSDK.Resource, only: :macros

  @path "/events"
  @resource_type "events"
  @enforce_keys [
    :id,
    :code,
    :payload,
    :occurred_at,
    :created_at,
    :merchant,
    :__raw__,
    :__links__,
    :__relationships__
  ]
  defstruct [
    :id,
    :type,
    :code,
    :payload,
    :occurred_at,
    :created_at,
    :merchant,
    :__raw__,
    :__links__,
    :__relationships__
  ]

  with_list()
  with_show()

  def new(id, type, attributes, record, links) do
    %__MODULE__{
      id: id,
      type: type,
      code: EPTSDK.Encoder.fetch(attributes, "code"),
      payload: EPTSDK.Encoder.fetch(attributes, "payload"),
      occurred_at: EPTSDK.Encoder.fetch_datetime(attributes, "occurred_at"),
      created_at: EPTSDK.Encoder.fetch_datetime(attributes, "created_at"),
      merchant: EPTSDK.Encoder.fetch_relationship(record["relationships"], "merchant"),
      # TODO: turn into formal relationship structs
      __relationships__: record["relationships"],
      # TODO: turn into formal links structs
      __links__: record["links"] || links,
      __raw__: record
    }
  end
end
