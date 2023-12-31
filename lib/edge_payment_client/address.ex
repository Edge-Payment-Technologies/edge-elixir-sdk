defmodule EdgePaymentClient.Address do
  import EdgePaymentClient.Resource, only: :macros

  @path "/consumer_addresses"
  @resource_type "consumer_addresses"
  @enforce_keys [
    :id,
    :line_1,
    :city,
    :state,
    :zip,
    :country,
    :created_at,
    :updated_at,
    :__record__,
    :__links__,
    :__relationships__
  ]
  defstruct id: nil,
            type: @resource_type,
            line_1: nil,
            city: nil,
            state: nil,
            zip: nil,
            country: nil,
            created_at: nil,
            updated_at: nil,
            __record__: nil,
            __links__: [],
            __relationships__: nil

  @type t() :: %__MODULE__{
          id: String.t(),
          type: String.t(),
          line_1: EdgePaymentClient.field(String.t()),
          city: EdgePaymentClient.field(String.t()),
          state: EdgePaymentClient.field(String.t()),
          zip: EdgePaymentClient.field(String.t()),
          country: EdgePaymentClient.field(String.t()),
          created_at: EdgePaymentClient.field(String.t()),
          updated_at: EdgePaymentClient.field(String.t()),
          __record__: map(),
          __links__: list(map()),
          __relationships__: map() | nil
        }

  with_list()
  with_show()
  with_create()
  with_update()
  with_delete()
end
