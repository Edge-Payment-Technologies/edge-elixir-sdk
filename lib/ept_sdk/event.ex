defmodule EPTSDK.Event do
  import EPTSDK.Resource, only: :macros

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

  with_list()
  with_show()
end
