defmodule EdgePaymentClient.MerchantAccount do
  import EdgePaymentClient.Resource, only: :macros

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

  @type t() :: %__MODULE__{
          id: String.t(),
          type: String.t(),
          business_name: EdgePaymentClient.field(String.t()),
          #  TODO: Change to date time
          created_at: EdgePaymentClient.field(String.t()),
          updated_at: EdgePaymentClient.field(String.t()),
          __raw__: map(),
          __links__: map(),
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
