defmodule EPTSDK.WebhookSubscription do
  @moduledoc """
  A webhook subscription is the defintion of a listener for events that should send HTTP requests to the
  described interface.
  """
  import EPTSDK.Resource, only: :macros

  @path "/webhook_subscriptions"
  @resource_type "webhook_subscriptions"

  @fields %{
    mode: {:enum, values: [:live, :sandbox]},
    active: :boolean,
    concurrency_limit: :integer,
    description: :string,
    events: {:array, :string},
    secret_key: :string,
    url: :uri,
    created_at: :datetime,
    updated_at: :datetime
  }
  @relationships %{merchant: :one}

  defresource()

  deflist()
  defshow()
  defcreate()
  defupdate()
  defdelete()
end
