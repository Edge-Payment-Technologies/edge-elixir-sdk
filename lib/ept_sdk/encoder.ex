defmodule EPTSDK.Encoder do
  @moduledoc """
  An individual record from the Edge API.
  """
  @spec to_struct(map(), map()) :: struct()
  def to_struct(
        %{
          "id" => id,
          "type" => "payment_methods" = type,
          "attributes" => attributes
        } = record,
        links
      ),
      do: EPTSDK.PaymentMethod.new(id, type, attributes, record, links)

  def to_struct(
        %{
          "id" => id,
          "type" => "payment_demands" = type,
          "attributes" => attributes
        } = record,
        links
      ),
      do: EPTSDK.PaymentDemand.new(id, type, attributes, record, links)

  def to_struct(
        %{
          "id" => id,
          "type" => "refund_demands" = type,
          "attributes" => attributes
        } = record,
        links
      ),
      do: EPTSDK.RefundDemand.new(id, type, attributes, record, links)

  def to_struct(
        %{
          "id" => id,
          "type" => "consumer_addresses" = type,
          "attributes" => attributes
        } = record,
        links
      ),
      do: EPTSDK.ConsumerAddress.new(id, type, attributes, record, links)

  def to_struct(
        %{
          "id" => id,
          "type" => "customers" = type,
          "attributes" => attributes
        } = record,
        links
      ),
      do: EPTSDK.Customer.new(id, type, attributes, record, links)

  def to_struct(
        %{
          "id" => id,
          "type" => "merchants" = type,
          "attributes" => attributes
        } = record,
        links
      ),
      do: EPTSDK.Merchant.new(id, type, attributes, record, links)

  def to_struct(
        %{
          "id" => id,
          "type" => "events" = type,
          "attributes" => attributes
        } = record,
        links
      ),
      do: EPTSDK.Event.new(id, type, attributes, record, links)

  def to_struct(
        %{
          "id" => id,
          "type" => "payment_subscriptions" = type,
          "attributes" => attributes
        } = record,
        links
      ),
      do: EPTSDK.PaymentSubscriptions.new(id, type, attributes, record, links)

  def to_struct(
        %{
          "id" => id,
          "type" => "webhook_subscriptions" = type,
          "attributes" => attributes
        } = record,
        links
      ),
      do: EPTSDK.WebhookSubscription.new(id, type, attributes, record, links)

  def to_struct(record, links) when not is_map_key(record, "attributes") do
    to_struct(Map.put(record, "attributes", %{}), links)
  end

  def fetch(attributes, key) when is_map(attributes) and is_binary(key) do
    if Map.has_key?(attributes, key) do
      attributes[key]
    else
      %EPTSDK.PropertyNotAvailable{name: key, reason: :unfetched}
    end
  end

  def fetch(attributes, key, :atom) when is_map(attributes) and is_binary(key) do
    if Map.has_key?(attributes, key) do
      String.to_atom(attributes[key])
    else
      %EPTSDK.PropertyNotAvailable{name: key, reason: :unfetched}
    end
  end

  def fetch(attributes, [cents_key, currency_key], :money)
      when is_map(attributes) and is_binary(cents_key) and is_binary(currency_key) do
    with true <- Map.has_key?(attributes, cents_key),
         true <- Map.has_key?(attributes, currency_key),
         cents when is_integer(cents) <- Map.get(attributes, cents_key),
         currency when is_binary(currency) <- Map.get(attributes, currency_key) do
      Money.new(cents, currency)
    else
      false -> %EPTSDK.PropertyNotAvailable{name: [cents_key, currency_key], reason: :unfetched}
      nil -> nil
      _ -> %EPTSDK.PropertyNotAvailable{name: [cents_key, currency_key], reason: :decoding_error}
    end
  end

  def fetch_datetime(attributes, key) when is_map(attributes) and is_binary(key) do
    with true <- Map.has_key?(attributes, key),
         value when not is_nil(value) <- Map.get(attributes, key),
         {:ok, timestamp} <- Timex.parse(value, "{ISO:Extended:Z}") do
      timestamp
    else
      false -> %EPTSDK.PropertyNotAvailable{name: key, reason: :unfetched}
      nil -> nil
      {:error, _message} -> %EPTSDK.PropertyNotAvailable{name: key, reason: :decoding_error}
    end
  end

  def fetch_relationship(relationships, key)
      when is_map(relationships) and is_binary(key) do
    Map.get(relationships, key)
    |> case do
      nil ->
        %EPTSDK.RelationshipNotAvailable{
          name: key,
          reason: :undefined_relationship
        }

      relationship ->
        decode_relationship(key, relationship)
    end
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

  defp decode_relationship(key, _relationship) do
    %EPTSDK.RelationshipNotAvailable{
      name: key,
      reason: :unfetched
    }
  end
end
