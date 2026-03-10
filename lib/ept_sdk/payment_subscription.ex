defmodule EPTSDK.PaymentSubscription do
  import EPTSDK.Resource, only: :macros

  @moduledoc """
  A recurring payment agreement for charging a customer on a billing schedule.

  First-cycle proration is controlled by `:proration_behavior`.

  When a payment subscription is created or confirmed with
  `proration_behavior: :create_prorations` and a future `billing_cycle_anchor_at`,
  Edge creates an immediate prorated first charge for the remaining portion of the
  current billing period while preserving the billing anchor for the first full cycle.

  When `proration_behavior: :none`, Edge skips the immediate prorated charge and
  delays the first charge until `billing_cycle_anchor_at`.
  """

  @path "/payment_subscriptions"
  @resource_type "payment_subscriptions"
  @fields %{
    description: :string,
    amount: {:money, cents: :amount_cents, currency: :amount_currency},
    amount_cents: :integer,
    amount_currency: {:enum, values: [:USD]},
    slug: :string,
    status: {:enum, values: [:incomplete, :ready, :active, :cancelled, :paused]},
    current_period_start_at: :datetime,
    current_period_end_at: :datetime,
    total_collected: {:money, cents: :total_collected, currency: :amount_currency},
    payer_timezone: :string,
    purchase_kind: {:enum, values: [:order, :invoice]},
    purchase_reference: :string,
    trial_end_at: :datetime,
    proration_behavior: {:enum, values: [:none, :create_prorations]},
    billing_cycle_anchor_at: :datetime,
    billing_period:
      {:enum,
       values: [
         :one_day,
         :seven_days,
         :fourteen_days,
         :thirty_days,
         :one_month,
         :six_months,
         :twelve_months
       ]},
    line_items: {:array, :map},
    shipping_detail: :map,
    tax_detail: :map,
    metadata: :map,
    billing_scheme: {:enum, values: [:per_unit]},
    next_billing_at: :datetime,
    discarded_at: :datetime,
    end_at: :datetime,
    canceled_at: :datetime,
    created_at: :datetime,
    updated_at: :datetime
  }
  @relationships %{
    processor_detail: :one,
    fee_plan: :one,
    merchant_token: :one,
    merchant_integration: :one,
    merchant: :one,
    payment_demands: :many,
    payment_method: :one,
    payer: :one,
    receiver: :one,
    buyer: :one,
    billing_address: :one,
    shipping_address: :one
  }

  defresource()

  deflist()
  defshow()
  defcreate()
  defupdate()

  @doc """
  Confirms an existing `%#{Kernel.inspect(__MODULE__)}` for processing.

  If the subscription is configured with `proration_behavior: :create_prorations`
  and a future `billing_cycle_anchor_at`, confirmation creates an immediate prorated
  first charge.

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

  defdelete()
end
