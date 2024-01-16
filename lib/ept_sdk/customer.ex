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
    :address,
    :payment_methods,
    :charges,
    :merchant_account,
    :__raw__,
    :__links__,
    :__relationships__
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
    :address,
    :payment_methods,
    :charges,
    :merchant_account,
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
