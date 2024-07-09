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
    :__links__,
    :__relationships__
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
    :__links__,
    :__relationships__
  ]

  with_list()
  with_show()
  with_update()
end
