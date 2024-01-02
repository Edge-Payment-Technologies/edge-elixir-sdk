defmodule EdgePaymentClient.Event do
  import EdgePaymentClient.Resource, only: :macros

  @path "/events"
  @resource_type "events"
  @enforce_keys [
    :id,
    :created_at,
    :__raw__,
    :__links__,
    :__relationships__
  ]
  defstruct [:id,
            :type,
            :created_at,
            :__raw__,
            :__links__,
            :__relationships__]

  @type t() :: %__MODULE__{
          id: String.t(),
          type: String.t(),
          #  TODO: Change to date time
          created_at: EdgePaymentClient.field(String.t()),
          __raw__: map(),
          __links__: map(),
          __relationships__: map() | nil
        }

  with_list()
  with_show()
end
