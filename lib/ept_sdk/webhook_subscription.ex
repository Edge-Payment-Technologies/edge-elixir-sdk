defmodule EPTSDK.WebhookSubscription do
  @moduledoc """
  A webhook subscription is the defintion of a listener for events that should send HTTP requests to the
  described interface.
  """
  import EPTSDK.Resource, only: :macros

  @path "/webhook_subscriptions"
  @resource_type "webhook_subscriptions"
  @enforce_keys [
    :id,
    :created_at,
    :updated_at,
    :merchant,
    :__raw__,
    :__links__
  ]
  defstruct [
    :id,
    :type,
    :active,
    :concurrency_limit,
    :description,
    :events,
    :secret_key,
    :url,
    :created_at,
    :updated_at,
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
      active: EPTSDK.Encoder.fetch(attributes, "active"),
      concurrency_limit: EPTSDK.Encoder.fetch(attributes, "concurrency_limit"),
      description: EPTSDK.Encoder.fetch(attributes, "description"),
      events: EPTSDK.Encoder.fetch(attributes, "events"),
      secret_key: EPTSDK.Encoder.fetch(attributes, "secret_key"),
      url: EPTSDK.Encoder.fetch(attributes, "url"),
      created_at: EPTSDK.Encoder.fetch_datetime(attributes, "created_at"),
      updated_at: EPTSDK.Encoder.fetch_datetime(attributes, "updated_at"),
      merchant: EPTSDK.Encoder.fetch_relationship(record["relationships"], "merchant"),
      # TODO: turn into formal links structs
      __links__: record["links"] || links,
      __raw__: record
    }
  end
end
