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
    :__raw__,
    :__links__,
    :__relationships__
  ]
  defstruct [:id,
            :type,
            :card_cvv_token,
            :card_pan_token,
            :description,
            :name,
            :expiry_month,
            :expiry_year,
            :created_at,
            :updated_at,
            :__raw__,
            :__links__,
            :__relationships__]

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
          __raw__: map(),
          __links__: map(),
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
