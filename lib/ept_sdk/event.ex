defmodule EPTSDK.Event do
  import EPTSDK.Resource, only: :macros

  @path "/events"
  @resource_type "events"
  @enforce_keys [
    :id,
    :code,
    :payload,
    :occurred_at,
    :created_at,
    :__raw__,
    :__links__,
    :__relationships__
  ]
  defstruct [:id,
            :type,
            :code,
            :payload,
            :occurred_at,
            :created_at,
            :__raw__,
            :__links__,
            :__relationships__]

  with_list()
  with_show()
end
