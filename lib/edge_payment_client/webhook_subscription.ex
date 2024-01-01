defmodule EdgePaymentClient.WebhookSubscription do
  import EdgePaymentClient.Resource, only: :macros

  @path "/webhook_subscriptions"
  @resource_type "webhook_subscriptions"
  @enforce_keys [
    :id,
    :created_at,
    :updated_at,
    :__record__,
    :__links__,
    :__relationships__
  ]
  defstruct id: nil,
            type: @resource_type,
            created_at: nil,
            updated_at: nil,
            __record__: nil,
            __links__: [],
            __relationships__: nil

  @type t() :: %__MODULE__{
          id: String.t(),
          type: String.t(),
          #  TODO: Change to date time
          created_at: EdgePaymentClient.field(String.t()),
          updated_at: EdgePaymentClient.field(String.t()),
          __record__: map(),
          __links__: list(map()),
          __relationships__: map() | nil
        }
  @type attributes_for_create() :: %{}
  @type relationships_for_create() :: %{}
  @type attributes_for_update() :: %{}
  @type relationships_for_update() :: %{}

  with_list()
  with_show()
  with_create()
  with_update()
  with_delete()
end
