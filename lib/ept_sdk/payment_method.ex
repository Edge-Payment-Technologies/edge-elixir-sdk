defmodule EPTSDK.PaymentMethod do
  import EPTSDK.Resource, only: :macros

  @path "/payment_methods"
  @resource_type "payment_methods"

  @fields %{
    nickname: :string,
    card_pan_token: :string,
    card_cvv_token: :string,
    routing_number_token: :string,
    account_number_token: :string,
    expiry_month: :string,
    expiry_year: :string,
    card_bin: :string,
    last_four: :string,
    external_state: {:enum, values: [:pending, :confirmed, :failed, :errored]},
    kind:
      {:enum,
       values: [
         :visa,
         :mastercard,
         :amex,
         :discover,
         :diners,
         :elo,
         :hiper,
         :hipercard,
         :jcb,
         :maestro,
         :mir,
         :unionpay,
         :checking,
         :savings
       ]},
    discarded_at: :datetime,
    created_at: :datetime,
    updated_at: :datetime
  }
  @relationships %{
    merchant: :one,
    payment_demands: :many,
    customer: :one,
    address: :one
  }

  defresource()
  deflist()
  defshow()
  defcreate()
  defupdate()
  defdelete()
end
