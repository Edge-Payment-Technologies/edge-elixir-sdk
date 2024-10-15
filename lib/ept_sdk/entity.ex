defmodule EPTSDK.Entity do
  @moduledoc """
  An individual record from the Edge API.
  """
  def to_struct(
        %{
          "id" => id,
          "type" => "payment_methods" = type,
          "attributes" => attributes
        } = record,
        links,
        included
      ),
      do: %EPTSDK.PaymentMethod{
        id: id,
        type: type,
        card_pan_token: fetch(attributes, "card_pan_token"),
        card_cvv_token: fetch(attributes, "card_cvv_token"),
        expiry_month: fetch(attributes, "expiry_month"),
        expiry_year: fetch(attributes, "expiry_year"),
        card_bin: fetch(attributes, "card_bin"),
        card_last_four: fetch(attributes, "card_last_four"),
        external_state: fetch(attributes, "external_state"),
        kind: fetch(attributes, "kind"),
        discarded_at: fetch_datetime(attributes, "discarded_at"),
        created_at: fetch_datetime(attributes, "created_at"),
        updated_at: fetch_datetime(attributes, "updated_at"),
        merchant:
          fetch_relationship(record["relationships"], "merchant", included),
        payment_demands: fetch_relationship(record["relationships"], "payment_demands", included),
        customer: fetch_relationship(record["relationships"], "customer", included),
        address: fetch_relationship(record["relationships"], "address", included),
        __relationships__: record["relationships"],
        __links__: record["links"] || links,
        __raw__: record
      }

  def to_struct(
        %{
          "id" => id,
          "type" => "payment_demands" = type,
          "attributes" => attributes
        } = record,
        links,
        included
      ),
      do: %EPTSDK.PaymentDemand{
        id: id,
        type: type,
        amount: fetch_money(attributes, ["amount_cents", "currency"]),
        amount_cents: fetch(attributes, "amount_cents"),
        fee: fetch_money(attributes, ["fee_cents", "currency"]),
        fee_cents: fetch(attributes, "fee_cents"),
        gateway: fetch_money(attributes, ["gateway_cents", "currency"]),
        gateway_cents: fetch(attributes, "gateway_cents"),

        net: fetch_money(attributes, ["net_cents", "currency"]),
        net_cents: fetch(attributes, "net_cents"),
        currency: fetch(attributes, "currency"),
        description: fetch(attributes, "description"),
        expires_at: fetch_datetime(attributes, "expires_at"),
        created_at: fetch_datetime(attributes, "created_at"),
        updated_at: fetch_datetime(attributes, "updated_at"),
        buyer: fetch_relationship(record["relationships"], "buyer", included),
        receiver: fetch_relationship(record["relationships"], "receiver", included),
        payer: fetch_relationship(record["relationships"], "payer", included),
        payment_method: fetch_relationship(record["relationships"], "payment_method", included),
        billing_address: fetch_relationship(record["relationships"], "billing_address", included),
        payment_subscription: fetch_relationship(record["relationships"], "payment_subscription", included),
        refund_demands: fetch_relationship(record["relationships"], "refund_demands", included),
        shipping_address:
          fetch_relationship(record["relationships"], "shipping_address", included),
        merchant:
          fetch_relationship(record["relationships"], "merchant", included),
        __relationships__: record["relationships"],
        __links__: record["links"] || links,
        __raw__: record
      }

  def to_struct(
        %{
          "id" => id,
          "type" => "consumer_addresses" = type,
          "attributes" => attributes
        } = record,
        links,
        included
      ),
      do: %EPTSDK.ConsumerAddress{
        id: id,
        type: type,
        line_1: fetch(attributes, "line_1"),
        line_2: fetch(attributes, "line_2"),
        city: fetch(attributes, "city"),
        state: fetch(attributes, "state"),
        zip: fetch(attributes, "zip"),
        country: fetch(attributes, "country"),
        created_at: fetch_datetime(attributes, "created_at"),
        updated_at: fetch_datetime(attributes, "updated_at"),
        merchant:
          fetch_relationship(record["relationships"], "merchant", included),
        __relationships__: record["relationships"],
        __links__: record["links"] || links,
        __raw__: record
      }

  def to_struct(
        %{
          "id" => id,
          "type" => "customers" = type,
          "attributes" => attributes
        } = record,
        links,
        included
      ),
      do: %EPTSDK.Customer{
        id: id,
        type: type,
        name: fetch(attributes, "name"),
        email: fetch(attributes, "email"),
        phone_number: fetch(attributes, "phone_number"),
        discarded_at: fetch(attributes, "discarded_at"),
        blocked_at: fetch_datetime(attributes, "blocked_at"),
        created_at: fetch_datetime(attributes, "created_at"),
        updated_at: fetch_datetime(attributes, "updated_at"),
        address: fetch_relationship(record["relationships"], "address", included),
        payment_methods: fetch_relationship(record["relationships"], "payment_methods", included),
        merchant:
          fetch_relationship(record["relationships"], "merchant", included),
        payment_demands: fetch_relationship(record["relationships"], "payment_demands", included),
        # TODO: turn into formal relationship structs
        __relationships__: record["relationships"],
        # TODO: turn into formal links structs
        __links__: record["links"] || links,
        __raw__: record
      }

  def to_struct(
        %{
          "id" => id,
          "type" => "merchants" = type,
          "attributes" => attributes
        } = record,
        links,
        included
      ),
      do: %EPTSDK.Merchant{
        id: id,
        type: type,
        average_monthly_transaction_volume_cents:
          fetch(attributes, "average_monthly_transaction_volume_cents"),
        average_transaction_size_cents: fetch(attributes, "average_transaction_size_cents"),
        business_address: fetch(attributes, "business_address"),
        business_address_line_2: fetch(attributes, "business_address_line_2"),
        business_city_name: fetch(attributes, "business_city_name"),
        business_country: fetch(attributes, "business_country"),
        business_description: fetch(attributes, "business_description"),
        business_name: fetch(attributes, "business_name"),
        business_privacy_url: fetch(attributes, "business_privacy_url"),
        business_state: fetch(attributes, "business_state"),
        business_support_email: fetch(attributes, "business_support_email"),
        business_support_url: fetch(attributes, "business_support_url"),
        business_terms_url: fetch(attributes, "business_terms_url"),
        business_timezone: fetch(attributes, "business_timezone"),
        business_website: fetch(attributes, "business_website"),
        business_zip_code: fetch(attributes, "business_zip_code"),
        max_transaction_size_cents: fetch(attributes, "max_transaction_size_cents"),
        phone_number: fetch(attributes, "phone_number"),
        public_business_name: fetch(attributes, "public_business_name"),
        shortened_descriptor: fetch(attributes, "shortened_descriptor"),
        statement_descriptor: fetch(attributes, "statement_descriptor"),
        active_at: fetch_datetime(attributes, "active_at"),
        manual_review_at: fetch_datetime(attributes, "manual_review_at"),
        pending_at: fetch_datetime(attributes, "pending_at"),
        created_at: fetch_datetime(attributes, "created_at"),
        updated_at: fetch_datetime(attributes, "updated_at"),
        customers: fetch_relationship(record["relationships"], "customers", included),
        consumer_addresses:
          fetch_relationship(record["relationships"], "consumer_addresses", included),
        payment_methods: fetch_relationship(record["relationships"], "payment_methods", included),
        payment_demands: fetch_relationship(record["relationships"], "payment_demands", included),
        events: fetch_relationship(record["relationships"], "events", included),
        webhook_subscriptions:
          fetch_relationship(record["relationships"], "webhook_subscriptions", included),
        payment_subscriptions: fetch_relationship(record["relationships"], "payment_subscriptions", included),
        # TODO: turn into formal relationship structs
        __relationships__: record["relationships"],
        # TODO: turn into formal links structs
        __links__: record["links"] || links,
        __raw__: record
      }

  def to_struct(
        %{
          "id" => id,
          "type" => "events" = type,
          "attributes" => attributes
        } = record,
        links,
        included
      ),
      do: %EPTSDK.Event{
        id: id,
        type: type,
        code: fetch(attributes, "code"),
        payload: fetch(attributes, "payload"),
        occurred_at: fetch_datetime(attributes, "occurred_at"),
        created_at: fetch_datetime(attributes, "created_at"),
        merchant:
          fetch_relationship(record["relationships"], "merchant", included),
        # TODO: turn into formal relationship structs
        __relationships__: record["relationships"],
        # TODO: turn into formal links structs
        __links__: record["links"] || links,
        __raw__: record
      }

  def to_struct(
        %{
          "id" => id,
          "type" => "payment_subscriptions" = type,
          "attributes" => attributes
        } = record,
        links,
        included
      ),
      do: %EPTSDK.PaymentSubscriptions{
        id: id,
        type: type,
        amount_cents: fetch(attributes, "amount_cents"),
        amount_currency: fetch(attributes, "amount_currency"),
        billing_period: fetch(attributes, "billing_period"),
        description: fetch(attributes, "description"),
        next_billing_day: fetch(attributes, "next_billing_day"),
        status: fetch(attributes, "status"),
        next_billing: fetch_datetime(attributes, "next_billing"),
        discarded_at: fetch_datetime(attributes, "discarded_at"),
        end_at: fetch_datetime(attributes, "end_at"),
        created_at: fetch_datetime(attributes, "created_at"),
        updated_at: fetch_datetime(attributes, "updated_at"),
        merchant:
          fetch_relationship(record["relationships"], "merchant", included),
        payment_demands: fetch_relationship(record["relationships"], "payment_demands", included),
        payment_method: fetch_relationship(record["relationships"], "payment_method", included),
        customer: fetch_relationship(record["relationships"], "customer", included),
        # TODO: turn into formal relationship structs
        __relationships__: record["relationships"],
        # TODO: turn into formal links structs
        __links__: record["links"] || links,
        __raw__: record
      }

  def to_struct(
        %{
          "id" => id,
          "type" => "webhook_subscriptions" = type,
          "attributes" => attributes
        } = record,
        links,
        included
      ),
      do: %EPTSDK.WebhookSubscription{
        id: id,
        type: type,
        active: fetch(attributes, "active"),
        concurrency_limit: fetch(attributes, "concurrency_limit"),
        description: fetch(attributes, "description"),
        events: fetch(attributes, "events"),
        secret_key: fetch(attributes, "secret_key"),
        url: fetch(attributes, "url"),
        created_at: fetch_datetime(attributes, "created_at"),
        updated_at: fetch_datetime(attributes, "updated_at"),
        merchant:
          fetch_relationship(record["relationships"], "merchant", included),
        # TODO: turn into formal relationship structs
        __relationships__: record["relationships"],
        # TODO: turn into formal links structs
        __links__: record["links"] || links,
        __raw__: record
      }

  def to_struct(record, links, included) when not is_map_key(record, "attributes") do
    to_struct(Map.put(record, "attributes", %{}), links, included)
  end

  defp fetch(attributes, key) when is_map(attributes) and is_binary(key) do
    if Map.has_key?(attributes, key) do
      attributes[key]
    else
      %EPTSDK.PropertyNotAvailable{name: key, reason: :unfetched}
    end
  end

  defp fetch_money(attributes, [cents_key, currency_key])
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

  defp fetch_datetime(attributes, key) when is_map(attributes) and is_binary(key) do
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

  defp fetch_relationship(relationships, key, []) do
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

  defp fetch_relationship(relationships, key, included)
       when is_map(relationships) and is_binary(key) and is_list(included) do
    Map.get(relationships, key)
    |> case do
      nil -> {:error, :unknown_relationship}
      relationship -> {:ok, decode_relationship(relationship)}
    end
    |> case do
      {:error, _} = error -> error
      {:ok, nil} -> {:ok, []}
      {:ok, relation} -> {:ok, find_by_relation(included, relation)}
    end
    |> case do
      {:error, _} = error -> error
      {:ok, nil} -> {:error, :not_included}
      {:ok, data} when is_list(data) -> data |> Enum.map(&to_struct(&1, nil, included))
      {:ok, data} -> to_struct(data, nil, included)
    end
    |> case do
      {:error, reason} ->
        %EPTSDK.RelationshipNotAvailable{
          name: key,
          reason: reason
        }

      record ->
        record
    end
  end

  defp decode_relationship(%{"data" => %{"id" => id, "type" => type}} = relationship)
       when is_map(relationship) do
    {id, type}
  end

  defp decode_relationship(%{} = relationship) when is_map(relationship), do: nil

  defp find_by_relation(included, {id, type}),
    do:
      Enum.find(included, fn %{"id" => included_id, "type" => included_type} ->
        included_type == type && included_id == id
      end)
end
