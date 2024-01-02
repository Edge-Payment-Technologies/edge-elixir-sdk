defmodule EdgePaymentClient.Subscription do
  import EdgePaymentClient.Resource, only: :macros

  @path "/subscriptions"
  @resource_type "subscriptions"
  @enforce_keys [
    :id,
    :created_at,
    :updated_at,
    :__raw__,
    :__links__,
    :__relationships__
  ]
  defstruct [:id,
            :type,
            :created_at,
            :updated_at,
            :__raw__,
            :__links__,
            :__relationships__]

  @type t() :: %__MODULE__{
          id: String.t(),
          type: String.t(),
          #  TODO: Change to date time
          created_at: EdgePaymentClient.field(String.t()),
          updated_at: EdgePaymentClient.field(String.t()),
          __raw__: map(),
          __links__: map(),
          __relationships__: map() | nil
        }
  @type attributes_for_create() :: %{}
  @type relationships_for_create() :: %{}
  @type attributes_for_update() :: %{}
  @type relationships_for_update() :: %{}

  with_list()
  with_show()
  with_create()
  with_delete()
end
