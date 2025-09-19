defmodule EPTSDK.Encoder do
  @moduledoc """
  An individual record from the Edge API.
  """
  @spec to_struct(map(), map(), EPTSDK.t()) :: struct()
  def to_struct(
        %{
          "id" => id,
          "type" => "payment_methods" = type
        } = record,
        links,
        client
      )
      when is_struct(client, EPTSDK),
      do: EPTSDK.PaymentMethod.new(id, type, record, links, client)

  def to_struct(
        %{
          "id" => id,
          "type" => "payment_demands" = type
        } = record,
        links,
        client
      )
      when is_struct(client, EPTSDK),
      do: EPTSDK.PaymentDemand.new(id, type, record, links, client)

  def to_struct(
        %{
          "id" => id,
          "type" => "refund_demands" = type
        } = record,
        links,
        client
      )
      when is_struct(client, EPTSDK),
      do: EPTSDK.RefundDemand.new(id, type, record, links, client)

  def to_struct(
        %{
          "id" => id,
          "type" => "consumer_addresses" = type
        } = record,
        links,
        client
      )
      when is_struct(client, EPTSDK),
      do: EPTSDK.ConsumerAddress.new(id, type, record, links, client)

  def to_struct(
        %{
          "id" => id,
          "type" => "customers" = type
        } = record,
        links,
        client
      )
      when is_struct(client, EPTSDK),
      do: EPTSDK.Customer.new(id, type, record, links, client)

  def to_struct(
        %{
          "id" => id,
          "type" => "merchants" = type
        } = record,
        links,
        client
      )
      when is_struct(client, EPTSDK),
      do: EPTSDK.Merchant.new(id, type, record, links, client)

  def to_struct(
        %{
          "id" => id,
          "type" => "events" = type
        } = record,
        links,
        client
      )
      when is_struct(client, EPTSDK),
      do: EPTSDK.Event.new(id, type, record, links, client)

  def to_struct(
        %{
          "id" => id,
          "type" => "payment_subscriptions" = type
        } = record,
        links,
        client
      )
      when is_struct(client, EPTSDK),
      do: EPTSDK.PaymentSubscriptions.new(id, type, record, links, client)

  def to_struct(
        %{
          "id" => id,
          "type" => "webhook_subscriptions" = type
        } = record,
        links,
        client
      )
      when is_struct(client, EPTSDK),
      do: EPTSDK.WebhookSubscription.new(id, type, record, links, client)

  def to_struct(record, links, client)
      when not is_map_key(record, "attributes") and is_struct(client, EPTSDK) do
    to_struct(Map.put(record, "attributes", %{}), links, client)
  end

  def fetch_field(_, _, _, _, options \\ [])

  def fetch_field(attributes, name, :money, selected, options) do
    cents_field = Keyword.get(options, :cents)
    currency_field = Keyword.get(options, :currency)

    cents = fetch_field(attributes, cents_field, :integer, selected, options)
    currency = fetch_field(attributes, currency_field, :enum, selected, options)

    cond do
      selected != [] and (cents_field not in selected or currency_field not in selected) ->
        %EPTSDK.PropertyNotAvailable{name: Atom.to_string(name), reason: :unfetched}

      is_integer(cents) and is_atom(currency) and
          (selected == [] or (cents_field in selected or currency_field in selected)) ->
        {cents, currency}

      true ->
        %EPTSDK.PropertyNotAvailable{name: Atom.to_string(name), reason: :decoding_error}
    end
  end

  def fetch_field(attributes, name, _type, selected, _options) do
    key = Atom.to_string(name)

    cond do
      selected != [] and key not in selected ->
        %EPTSDK.PropertyNotAvailable{name: key, reason: :unfetched}

      (selected == [] or key in selected) and is_map_key(attributes, key) ->
        Map.get(attributes, key)

      true ->
        %EPTSDK.PropertyNotAvailable{name: Atom.to_string(name), reason: :undefined}
    end
  end

  def fetch_relationship(_, _, _, options \\ [])

  def fetch_relationship(relationships, name, includes, _options) do
    key = Atom.to_string(name)

    cond do
      includes != [] and key not in includes ->
        %EPTSDK.PropertyNotAvailable{name: key, reason: :unfetched}

      (includes == [] or key in includes) and is_map_key(relationships, key) ->
        Map.get(relationships, key)

      true ->
        %EPTSDK.RelationshipNotAvailable{name: key, reason: :undefined}
    end
  end

  def cast(_, _, _, options \\ [])

  def cast(value, _name, _type, _options) when is_struct(value, EPTSDK.PropertyNotAvailable) do
    value
  end

  def cast(nil, _name, _type, _options) do
    nil
  end

  def cast({cents, currency}, _name, :money, _options) do
    Money.new(cents, currency)
  end

  def cast(value, name, :datetime, _options) do
    DateTime.from_iso8601(value, "{ISO:Extended:Z}")
    |> case do
      {:ok, timestamp, _usec} -> timestamp
      {:error, _reason} -> %EPTSDK.PropertyNotAvailable{name: name, reason: :decoding_error}
    end
  end

  def cast(value, name, kind, _options) when kind in [:one, :many] do
    decode_relationship(Atom.to_string(name), value)
  end

  def cast(value, _name, _type, _options) do
    value
  end

  defp decode_relationship(key, %{"data" => data}) when is_list(data) do
    %EPTSDK.Relationship{
      name: key,
      has: :many,
      data:
        Enum.map(data, fn %{"id" => id, "type" => type} ->
          %{id: id, type: type}
        end)
    }
  end

  defp decode_relationship(key, %{"data" => %{"id" => id, "type" => type}}) do
    %EPTSDK.Relationship{name: key, has: :one, data: %{id: id, type: type}}
  end

  defp decode_relationship(key, relationship) when is_map(relationship) do
    # relationship = %{
    #   "links" => %{
    #     "self" =>
    #       "https://api.tryedge.test:4001/v2/payment_demands/4006bc5f-89d2-495b-92ee-e2711d7cb266/relationships/buyer"
    #   }
    # }
    %EPTSDK.RelationshipNotAvailable{
      name: key,
      reason: :unfetched
    }
  end
end
