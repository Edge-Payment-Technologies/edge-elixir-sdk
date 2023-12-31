defmodule EdgePaymentClient.Customer do
  import EdgePaymentClient.Resource, only: :macros

  @path "/customers"
  @resource_type "customers"
  @enforce_keys [
    :id,
    :name,
    :email,
    :created_at,
    :updated_at,
    :__record__,
    :__links__,
    :__relationships__
  ]
  defstruct id: nil,
            name: nil,
            email: nil,
            created_at: nil,
            updated_at: nil,
            __record__: nil,
            __links__: [],
            __relationships__: nil

  @type t() :: %__MODULE__{
          id: String.t(),
          name: EdgePaymentClient.field(String.t()),
          email: EdgePaymentClient.field(String.t()),
          #  TODO: Change to date time
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
