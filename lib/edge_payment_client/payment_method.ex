defmodule EdgePaymentClient.PaymentMethod do
  import EdgePaymentClient.Resource, only: :macros

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
    :__record__,
    :__links__,
    :__relationships__
  ]
  defstruct id: nil,
            type: @resource_type,
            card_cvv_token: nil,
            card_pan_token: nil,
            description: "",
            name: "",
            expiry_month: nil,
            expiry_year: nil,
            created_at: nil,
            updated_at: nil,
            __record__: nil,
            __links__: [],
            __relationships__: nil

  @type t() :: %__MODULE__{
          id: String.t(),
          type: String.t(),
          card_cvv_token: String.t(),
          card_pan_token: String.t(),
          description: String.t() | nil,
          name: String.t() | nil,
          expiry_month: integer(),
          expiry_year: integer(),
          #  TODO: Change to date time
          created_at: EdgePaymentClient.field(String.t()),
          updated_at: EdgePaymentClient.field(String.t()),
          __record__: map(),
          __links__: list(map()),
          __relationships__: map() | nil
        }
  @type attributes_for_create() :: %{
          :card_cvv_token => String.t(),
          :card_pan_token => String.t(),
          optional(:description) => String.t(),
          optional(:name) => String.t(),
          :expiry_month => integer(),
          :expiry_year => integer()
        }
  @type relationships_for_create() :: %{
          :customer => EdgePaymentClient.Customer.t(),
          :address => EdgePaymentClient.Address.t()
        }
  @type attributes_for_update() :: %{
          optional(:description) => String.t(),
          optional(:name) => String.t()
        }
  @type relationships_for_update() :: %{
          optional(:customer) => EdgePaymentClient.Customer.t(),
          optional(:address) => EdgePaymentClient.Address.t()
        }

  with_list()
  with_show()
  with_create()
  with_update()
  with_delete()
end
