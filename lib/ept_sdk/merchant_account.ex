defmodule EPTSDK.MerchantAccount do
  import EPTSDK.Resource, only: :macros

  @path "/merchant_accounts"
  @resource_type "merchant_accounts"
  @enforce_keys [
    :id,
    :business_name,
    :created_at,
    :updated_at,
    :__raw__,
    :__links__,
    :__relationships__
  ]
  defstruct [:id,
            :type,
            :business_name,
            :created_at,
            :updated_at,
            :__raw__,
            :__links__,
            :__relationships__]

  with_list()
  with_show()
  with_update()
end
