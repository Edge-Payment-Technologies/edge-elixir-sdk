defmodule EPTSDK.Charge do
  import EPTSDK.Resource, only: :macros

  @path "/charges"
  @resource_type "charges"
  @enforce_keys [
    :id,
    :amount_cents,
    :currency,
    # :customer
    # :payment_method
    # :shipping_address
    :created_at,
    :updated_at,
    :__raw__,
    :__links__,
    :__relationships__
  ]
  defstruct [:id,
            :type,
            :amount_cents,
            :currency,
            :description,
            # customer
            # payment_method
            # shipping_address
            :created_at,
            :updated_at,
            :__raw__,
            :__links__,
            :__relationships__]

  with_list()
  with_show()
  with_create()
end
