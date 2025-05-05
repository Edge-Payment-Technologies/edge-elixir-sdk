defmodule EPTSDK.PaymentDemand do
  import EPTSDK.Resource, only: :macros

  @path "/payment_demands"
  @resource_type "payment_demands"
  @enforce_keys [
    :id,
    :amount,
    :amount_cents,
    :amount_currency,
    :net,
    :net_cents,
    :fee,
    :fee_cents,
    :created_at,
    :updated_at,
    :merchant,
    :buyer,
    :receiver,
    :payer,
    :payment_method,
    :billing_address,
    :payment_subscription,
    :shipping_address,
    :processor_state,
    :__raw__,
    :__links__
  ]
  defstruct [
    :id,
    :type,
    :amount,
    :amount_cents,
    :amount_currency,
    :net,
    :net_cents,
    :fee,
    :fee_cents,
    :description,
    :idempotency_key,
    :processor_state,
    :created_at,
    :updated_at,
    :merchant,
    :buyer,
    :receiver,
    :payer,
    :payment_method,
    :billing_address,
    :refund_demands,
    :payment_subscription,
    :shipping_address,
    :__raw__,
    :__links__
  ]

  with_list()
  with_show()
  with_create()
  with_update()

  def new(id, type, attributes, record, links) do
    %__MODULE__{
      id: id,
      type: type,
      amount: EPTSDK.Encoder.fetch(attributes, ["amount_cents", "amount_currency"], :money),
      amount_cents: EPTSDK.Encoder.fetch(attributes, "amount_cents"),
      amount_currency: EPTSDK.Encoder.fetch(attributes, "amount_currency"),
      fee: EPTSDK.Encoder.fetch(attributes, ["fee_cents", "amount_currency"], :money),
      fee_cents: EPTSDK.Encoder.fetch(attributes, "fee_cents"),
      net: EPTSDK.Encoder.fetch(attributes, ["net_cents", "amount_currency"], :money),
      net_cents: EPTSDK.Encoder.fetch(attributes, "net_cents"),
      idempotency_key: EPTSDK.Encoder.fetch(attributes, "idempotency_key"),
      processor_state: EPTSDK.Encoder.fetch(attributes, "processor_state", :atom),
      description: EPTSDK.Encoder.fetch(attributes, "description"),
      created_at: EPTSDK.Encoder.fetch_datetime(attributes, "created_at"),
      updated_at: EPTSDK.Encoder.fetch_datetime(attributes, "updated_at"),
      buyer: EPTSDK.Encoder.fetch_relationship(record["relationships"], "buyer"),
      receiver: EPTSDK.Encoder.fetch_relationship(record["relationships"], "receiver"),
      payer: EPTSDK.Encoder.fetch_relationship(record["relationships"], "payer"),
      payment_method:
        EPTSDK.Encoder.fetch_relationship(record["relationships"], "payment_method"),
      billing_address:
        EPTSDK.Encoder.fetch_relationship(record["relationships"], "billing_address"),
      payment_subscription:
        EPTSDK.Encoder.fetch_relationship(
          record["relationships"],
          "payment_subscription"
        ),
      refund_demands:
        EPTSDK.Encoder.fetch_relationship(record["relationships"], "refund_demands"),
      shipping_address:
        EPTSDK.Encoder.fetch_relationship(record["relationships"], "shipping_address"),
      merchant: EPTSDK.Encoder.fetch_relationship(record["relationships"], "merchant"),
      __links__: record["links"] || links,
      __raw__: record
    }
  end

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
    update(client, id, options)
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
