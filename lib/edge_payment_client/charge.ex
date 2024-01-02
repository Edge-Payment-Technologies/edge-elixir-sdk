defmodule EdgePaymentClient.Charge do
  import EdgePaymentClient.Resource, only: :macros

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

  @type t() :: %__MODULE__{
          id: String.t(),
          type: String.t(),
          # TODO: Amount money
          amount_cents: EdgePaymentClient.field(integer()),
          currency: EdgePaymentClient.field(String.t()),
          description: EdgePaymentClient.field(String.t()),
          # customer: EdgePaymentClient.Customer.t()
          # payment_method
          # shipping_address
          #  TODO: Change to date time
          created_at: EdgePaymentClient.field(String.t()),
          updated_at: EdgePaymentClient.field(String.t()),
          __raw__: map(),
          __links__: map(),
          __relationships__: map() | nil
        }
  @type attributes_for_create() :: %{
          :amount_cents => integer(),
          :currency => String.t(),
          optional(:description) => String.t()
        }
  @type relationships_for_create() :: %{
          customer: EdgePaymentClient.Customer.t(),
          payment_method: EdgePaymentClient.PaymentMethod.t(),
          shipping_address: EdgePaymentClient.Address.t()
        }

  with_list()
  with_show()
  with_create()
end
