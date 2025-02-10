defmodule EPTSDK.Encoder do
  @moduledoc """
  An individual record from the Edge API.
  """
  @spec to_struct(map(), map(), list()) :: struct()
  def to_struct(
        %{
          "id" => id,
          "type" => "payment_methods" = type,
          "attributes" => attributes
        } = record,
        links,
        included
      ),
      do: EPTSDK.PaymentMethod.new(id, type, attributes, record, included, links)

  def to_struct(
        %{
          "id" => id,
          "type" => "payment_demands" = type,
          "attributes" => attributes
        } = record,
        links,
        included
      ),
      do: EPTSDK.PaymentDemand.new(id, type, attributes, record, included, links)

  def to_struct(
        %{
          "id" => id,
          "type" => "refund_demands" = type,
          "attributes" => attributes
        } = record,
        links,
        included
      ),
      do: EPTSDK.RefundDemand.new(id, type, attributes, record, included, links)

  def to_struct(
        %{
          "id" => id,
          "type" => "consumer_addresses" = type,
          "attributes" => attributes
        } = record,
        links,
        included
      ),
      do: EPTSDK.ConsumerAddress.new(id, type, attributes, record, included, links)

  def to_struct(
        %{
          "id" => id,
          "type" => "customers" = type,
          "attributes" => attributes
        } = record,
        links,
        included
      ),
      do: EPTSDK.Customer.new(id, type, attributes, record, included, links)

  def to_struct(
        %{
          "id" => id,
          "type" => "merchants" = type,
          "attributes" => attributes
        } = record,
        links,
        included
      ),
      do: EPTSDK.Merchant.new(id, type, attributes, record, included, links)

  def to_struct(
        %{
          "id" => id,
          "type" => "events" = type,
          "attributes" => attributes
        } = record,
        links,
        included
      ),
      do: EPTSDK.Event.new(id, type, attributes, record, included, links)

  def to_struct(
        %{
          "id" => id,
          "type" => "payment_subscriptions" = type,
          "attributes" => attributes
        } = record,
        links,
        included
      ),
      do: EPTSDK.PaymentSubscriptions.new(id, type, attributes, record, included, links)

  def to_struct(
        %{
          "id" => id,
          "type" => "webhook_subscriptions" = type,
          "attributes" => attributes
        } = record,
        links,
        included
      ),
      do: EPTSDK.WebhookSubscription.new(id, type, attributes, record, included, links)

  def to_struct(record, links, included) when not is_map_key(record, "attributes") do
    to_struct(Map.put(record, "attributes", %{}), links, included)
  end

  def fetch(attributes, key) when is_map(attributes) and is_binary(key) do
    if Map.has_key?(attributes, key) do
      attributes[key]
    else
      %EPTSDK.PropertyNotAvailable{name: key, reason: :unfetched}
    end
  end

  def fetch_money(attributes, [cents_key, currency_key])
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

  def fetch_relationship(relationships, key, []) do
    Map.get(relationships, key)
    |> case do
      nil ->
        %EPTSDK.RelationshipNotAvailable{
          name: key,
          reason: :undefined_relationship
        }

      _relationship ->
        %EPTSDK.RelationshipNotAvailable{name: key, reason: :not_included}
    end
  end

  def fetch_relationship(relationships, key, included)
      when is_map(relationships) and is_binary(key) and is_list(included) do
    Map.get(relationships, key)
    |> case do
      nil ->
        %EPTSDK.RelationshipNotAvailable{
          name: key,
          reason: :unknown
        }

      relationship ->
        decode_relationship(key, relationship)
    end
  end

  defp decode_relationship(key, %{"data" => data}) when is_list(data) do
    Enum.map(data, fn %{"id" => id, "type" => type} ->
      %EPTSDK.Relationship{name: key, id: id, type: type}
    end)
  end

  defp decode_relationship(key, %{"data" => %{"id" => id, "type" => type}}) do
    %EPTSDK.Relationship{name: key, id: id, type: type}
  end

  defp decode_relationship(key, _relationship) do
    %EPTSDK.RelationshipNotAvailable{
      name: key,
      reason: :unfetched
    }
  end

  # defp find_by_relation(included, {id, type}) do
  #   dbg()

  #   Enum.find(included, fn %{"id" => included_id, "type" => included_type} ->
  #     included_type == type && included_id == id
  #   end)
  # end
end
