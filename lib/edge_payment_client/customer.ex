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
    :__raw__,
    :__links__,
    :__relationships__
  ]
  defstruct [:id,
            :type,
            :name,
            :email,
            :created_at,
            :updated_at,
            :__raw__,
            :__links__,
            :__relationships__]

  @type t() :: %__MODULE__{
          id: String.t(),
          type: String.t(),
          name: EdgePaymentClient.field(String.t()),
          email: EdgePaymentClient.field(String.t()),
          #  TODO: Change to date time
          created_at: EdgePaymentClient.field(String.t()),
          updated_at: EdgePaymentClient.field(String.t()),
          __raw__: map(),
          __links__: map(),
          __relationships__: map() | nil
        }
  @type attributes_for_create() :: %{
          :name => String.t(),
          optional(:email) => String.t()
        }
  @type relationships_for_create() :: %{
          optional(:address) => EdgePaymentClient.Address.t()
        }
  @type attributes_for_update() :: %{
          optional(:name) => String.t(),
          optional(:email) => String.t()
        }
  @type relationships_for_update() :: %{
          optional(:address) => EdgePaymentClient.Address.t()
        }

  with_list()
  with_show()
  with_create()
  with_update()
  with_delete()
end
