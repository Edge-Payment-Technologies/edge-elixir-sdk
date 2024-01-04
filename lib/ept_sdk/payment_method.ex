defmodule EPTSDK.PaymentMethod do
  import EPTSDK.Resource, only: :macros

  @path "/payment_methods"
  @resource_type "payment_methods"
  @enforce_keys [
    :id,
    :card_cvv_token,
    :card_pan_token,
    :expiry_month,
    :expiry_year,
    :created_at,
    :updated_at,
    :__raw__,
    :__links__,
    :__relationships__
  ]
  defstruct [:id,
            :type,
            :card_bin,
            :card_cvv_token,
            :card_last_four,
            :card_pan_token,
            :external_state,
            :kind,
            :description,
            :name,
            :expiry_month,
            :expiry_year,
            :discarded_at,
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
