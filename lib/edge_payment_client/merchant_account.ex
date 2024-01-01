defmodule EdgePaymentClient.MerchantAccount do
  import EdgePaymentClient.Resource, only: :macros

  @path "/merchant_accounts"
  @resource_type "merchant_accounts"
  @enforce_keys [
    :id,
    :business_name,
    :created_at,
    :updated_at,
    :__record__,
    :__links__,
    :__relationships__
  ]
  defstruct id: nil,
            type: @resource_type,
            business_name: nil,
            created_at: nil,
            updated_at: nil,
            __record__: nil,
            __links__: [],
            __relationships__: nil

  @type t() :: %__MODULE__{
          id: String.t(),
          type: String.t(),
          business_name: EdgePaymentClient.field(String.t()),
          #  TODO: Change to date time
          created_at: EdgePaymentClient.field(String.t()),
          updated_at: EdgePaymentClient.field(String.t()),
          __record__: map(),
          __links__: list(map()),
          __relationships__: map() | nil
        }

  @type attributes_for_update() :: %{
    optional(:business_name) => String.t()
  }

  @type relationships_for_update() :: %{}

  with_list()
  with_show()
  with_update()
end
