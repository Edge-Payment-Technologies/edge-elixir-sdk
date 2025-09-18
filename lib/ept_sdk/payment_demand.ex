defmodule EPTSDK.PaymentDemand do
  import EPTSDK.Resource, only: :macros

  @path "/payment_demands"
  @resource_type "payment_demands"

  @fields %{
    amount: {:money, cents: :amount_cents, currency: :amount_currency},
    amount_cents: :integer,
    amount_currency: {:enum, values: [:USD]},
    payer_timezone: :string,
    description: :string,
    idempotency_key: :string,
    processor_state:
      {:enum,
       values: [
         :incomplete,
         :ready,
         :pending,
         :processing,
         :succeeded,
         :reversed,
         :refunded,
         :failed,
         :disputed
       ]},
    purchase_kind: {:enum, values: [:order, :invoice]},
    purchase_reference: :string,
    customer_reference: :string,
    line_items: {:array, :map},
    shipping_detail: :map,
    tax_detail: :map,
    metadata: :map,
    capture_method: {:enum, values: [:automatic, :manual]},
    fee: {:money, cents: :fee_cents, currency: :amount_currency},
    fee_cents: :integer,
    confirmed: :boolean,
    refunded_at: :datetime,
    succeeded_at: :datetime,
    disputed_at: :datetime,
    reversed_at: :datetime,
    failed_at: :datetime,
    created_at: :datetime,
    updated_at: :datetime
  }

  @relationships %{
    processor_detail: :one,
    fee_plan: :one,
    merchant: :one,
    merchant_token: :one,
    merchant_integration: :one,
    buyer: :one,
    receiver: :one,
    payer: :one,
    payment_method: :one,
    refund_demands: :many,
    billing_address: :one,
    payment_subscription: :one,
    shipping_address: :one
  }

  defresource()

  deflist()
  defshow()
  defcreate()
  defupdate()

  @doc """
  Confirms an existing `%#{Kernel.inspect(__MODULE__)}` for processing.

  The `options` argument can also have:

    - `fields:`, a map of filds to return for each resource type i.e. `fields: %{#{@resource_type}: ["id"]}`
    - `include:`, a list of relationship chains for the response to return i.e. `include: ["#{@resource_type}.merchant"]`
  """
  def confirm(
        _,
        _,
        options \\ []
      )

  def confirm(
        %EPTSDK{} = client,
        %__MODULE__{id: id} = _record,
        options
      )
      when is_list(options) do
    confirm(client, id, options)
  end

  def confirm(
        %EPTSDK{} = client,
        id,
        options
      )
      when is_binary(id) and is_list(options) do
    client
    |> EPTSDK.patch(
      "#{@path}/#{id}/confirm",
      %{
        data: %{
          id: id,
          type: @resource_type,
          attributes: %{}
        }
      },
      options
    )
    |> EPTSDK.update_client_from_request(client)
    |> EPTSDK.Resource.from_payload()
  end
end
