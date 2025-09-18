defmodule EPTSDK.Event do
  import EPTSDK.Resource, only: :macros

  @path "/events"
  @resource_type "events"

  @fields %{
    mode: {:enum, values: [:live, :sandbox]},
    resource_id: :string,
    resource_type: :string,
    slug: {:enum, values: []},
    data: :map,
    created_at: :datetime
  }
  @relationships %{merchant: :one}

  defresource()

  deflist()
  defshow()
end
