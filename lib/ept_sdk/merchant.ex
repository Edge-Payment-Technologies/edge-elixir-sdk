defmodule EPTSDK.Merchant do
  import EPTSDK.Resource, only: :macros

  @path "/merchants"
  @resource_type "merchants"
  @enforce_keys [
    :id,
    :business_name,
    :created_at,
    :updated_at,
    :consumer_addresses,
    :payment_methods,
    :customers,
    :events,
    :payment_demands,
    :payment_subscriptions,
    :webhook_subscriptions,
    :__raw__,
    :__links__
  ]
  defstruct [
    :id,
    :type,
    :average_monthly_transaction_volume_cents,
    :average_transaction_size_cents,
    :business_address,
    :business_address_line_2,
    :business_city_name,
    :business_country,
    :business_description,
    :business_name,
    :business_privacy_url,
    :business_state,
    :business_support_email,
    :business_support_url,
    :business_terms_url,
    :business_timezone,
    :business_website,
    :business_zip_code,
    :max_transaction_size_cents,
    :phone_number,
    :public_business_name,
    :shortened_descriptor,
    :statement_descriptor,
    :active_at,
    :manual_review_at,
    :pending_at,
    :created_at,
    :updated_at,
    :customers,
    :consumer_addresses,
    :payment_methods,
    :events,
    :payment_demands,
    :payment_subscriptions,
    :webhook_subscriptions,
    :__raw__,
    :__links__
  ]

  with_list()
  with_show()
  with_update()

  def new(id, type, attributes, record, links) do
    %__MODULE__{
      id: id,
      type: type,
      business_address: EPTSDK.Encoder.fetch(attributes, "business_address"),
      business_address_line_2: EPTSDK.Encoder.fetch(attributes, "business_address_line_2"),
      business_city_name: EPTSDK.Encoder.fetch(attributes, "business_city_name"),
      business_country: EPTSDK.Encoder.fetch(attributes, "business_country"),
      business_description: EPTSDK.Encoder.fetch(attributes, "business_description"),
      business_name: EPTSDK.Encoder.fetch(attributes, "business_name"),
      business_privacy_url: EPTSDK.Encoder.fetch(attributes, "business_privacy_url"),
      business_state: EPTSDK.Encoder.fetch(attributes, "business_state"),
      business_support_email: EPTSDK.Encoder.fetch(attributes, "business_support_email"),
      business_support_url: EPTSDK.Encoder.fetch(attributes, "business_support_url"),
      business_terms_url: EPTSDK.Encoder.fetch(attributes, "business_terms_url"),
      business_timezone: EPTSDK.Encoder.fetch(attributes, "business_timezone"),
      business_website: EPTSDK.Encoder.fetch(attributes, "business_website"),
      business_zip_code: EPTSDK.Encoder.fetch(attributes, "business_zip_code"),
      max_transaction_size_cents: EPTSDK.Encoder.fetch(attributes, "max_transaction_size_cents"),
      average_monthly_transaction_volume_cents:
        EPTSDK.Encoder.fetch(attributes, "average_monthly_transaction_volume_cents"),
      average_transaction_size_cents:
        EPTSDK.Encoder.fetch(attributes, "average_transaction_size_cents"),
      phone_number: EPTSDK.Encoder.fetch(attributes, "phone_number"),
      public_business_name: EPTSDK.Encoder.fetch(attributes, "public_business_name"),
      shortened_descriptor: EPTSDK.Encoder.fetch(attributes, "shortened_descriptor"),
      statement_descriptor: EPTSDK.Encoder.fetch(attributes, "statement_descriptor"),
      active_at: EPTSDK.Encoder.fetch_datetime(attributes, "active_at"),
      manual_review_at: EPTSDK.Encoder.fetch_datetime(attributes, "manual_review_at"),
      pending_at: EPTSDK.Encoder.fetch_datetime(attributes, "pending_at"),
      created_at: EPTSDK.Encoder.fetch_datetime(attributes, "created_at"),
      updated_at: EPTSDK.Encoder.fetch_datetime(attributes, "updated_at"),
      customers: EPTSDK.Encoder.fetch_relationship(record["relationships"], "customers"),
      consumer_addresses:
        EPTSDK.Encoder.fetch_relationship(record["relationships"], "consumer_addresses"),
      payment_methods:
        EPTSDK.Encoder.fetch_relationship(record["relationships"], "payment_methods"),
      payment_demands:
        EPTSDK.Encoder.fetch_relationship(record["relationships"], "payment_demands"),
      events: EPTSDK.Encoder.fetch_relationship(record["relationships"], "events"),
      webhook_subscriptions:
        EPTSDK.Encoder.fetch_relationship(
          record["relationships"],
          "webhook_subscriptions"
        ),
      payment_subscriptions:
        EPTSDK.Encoder.fetch_relationship(
          record["relationships"],
          "payment_subscriptions"
        ),
      # TODO: turn into formal links structs
      __links__: record["links"] || links,
      __raw__: record
    }
  end
end
