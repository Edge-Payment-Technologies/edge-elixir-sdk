defmodule EPTSDK.PayoutMethod do
  import EPTSDK.Resource, only: :macros

  @path "/payout_methods"
  @resource_type "payout_methods"
  @enforce_keys [
    :id,
    :created_at,
    :updated_at,
    :__raw__,
    :__links__,
    :__relationships__
  ]
  defstruct [:id,
            :type,
            :account_number,
            :account_type,
            :institution_name,
            :payout_method_type,
            :routing_number,
            :verified_at,
            :created_at,
            :updated_at,
            :__raw__,
            :__links__,
            :__relationships__]

  with_list()
  with_show()
  with_create()
  with_update()
  with_delete()
end
