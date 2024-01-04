defmodule EPTSDK.Address do
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
    :__raw__,
    :__links__,
    :__relationships__
  ]

  with_list()
  with_show()
  with_create()
  with_update()
  with_delete()
end
