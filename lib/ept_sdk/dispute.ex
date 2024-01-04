defmodule EPTSDK.Dispute do
  import EPTSDK.Resource, only: :macros

  @path "/disputes"
  @resource_type "disputes"
  @enforce_keys [
    :id,
    :created_at,
    :updated_at,
    :__raw__,
    :__links__,
    :__relationships__
  ]
  defstruct [:id, :type, :created_at, :updated_at, :__raw__, :__links__, :__relationships__]

  with_list()
  with_show()
  with_create()
end
