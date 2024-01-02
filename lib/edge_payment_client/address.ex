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
    :__raw__,
    :__links__,
    :__relationships__
  ]
  defstruct [:id,
            :type,
            :line_1,
            :city,
            :state,
            :zip,
            :country,
            :created_at,
            :updated_at,
            :__raw__,
            :__links__,
            :__relationships__]


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
          __raw__: map(),
          __links__: map(),
          __relationships__: map() | nil
        }
  @type attributes_for_create() :: %{
          :line_1 => String.t(),
          optional(:line_1) => String.t(),
          :city => String.t(),
          :state => String.t(),
          :zip => String.t(),
          :country => String.t()
        }
  @type relationships_for_create() :: %{}
  @type attributes_for_update() :: %{
          optional(:line_1) => String.t(),
          optional(:line_1) => String.t(),
          optional(:city) => String.t(),
          optional(:state) => String.t(),
          optional(:zip) => String.t(),
          optional(:country) => String.t()
        }
  @type relationships_for_update() :: %{}

  with_list()
  with_show()
  with_create()
  with_update()
  with_delete()
end
