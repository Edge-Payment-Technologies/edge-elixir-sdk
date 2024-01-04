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
        links
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
        __relationships__: record["relationships"],
        __links__: record["links"] || links,
        __raw__: record
      }

  def to_struct(
        %{
          "id" => id,
          "type" => "charges" = type,
          "attributes" => attributes
        } = record,
        links
      ),
      do: %EPTSDK.Charge{
        id: id,
        type: type,
        amount_cents: fetch(attributes, "amount_cents"),
        currency: fetch(attributes, "currency"),
        description: fetch(attributes, "description"),
        created_at: fetch_datetime(attributes, "created_at"),
        updated_at: fetch_datetime(attributes, "updated_at"),
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
        links
      ),
      do: %EPTSDK.Address{
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
        links
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
        # TODO: turn into formal relationship structs
        __relationships__: record["relationships"],
        # TODO: turn into formal links structs
        __links__: record["links"] || links,
        __raw__: record
      }

  def to_struct(
        %{
          "id" => id,
          "type" => "merchant_accounts" = type,
          "attributes" => attributes
        } = record,
        links
      ),
      do: %EPTSDK.MerchantAccount{
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
        links
      ),
      do: %EPTSDK.Event{
        id: id,
        type: type,
        code: fetch(attributes, "code"),
        payload: fetch(attributes, "payload"),
        occurred_at: fetch_datetime(attributes, "occurred_at"),
        created_at: fetch_datetime(attributes, "created_at"),
        # TODO: turn into formal relationship structs
        __relationships__: record["relationships"],
        # TODO: turn into formal links structs
        __links__: record["links"] || links,
        __raw__: record
      }

  def to_struct(
        %{
          "id" => id,
          "type" => "disputes" = type,
          "attributes" => attributes
        } = record,
        links
      ),
      do: %EPTSDK.Dispute{
        id: id,
        type: type,
        created_at: fetch_datetime(attributes, "created_at"),
        updated_at: fetch_datetime(attributes, "updated_at"),
        # TODO: turn into formal relationship structs
        __relationships__: record["relationships"],
        # TODO: turn into formal links structs
        __links__: record["links"] || links,
        __raw__: record
      }

  def to_struct(
        %{
          "id" => id,
          "type" => "payout_methods" = type,
          "attributes" => attributes
        } = record,
        links
      ),
      do: %EPTSDK.PayoutMethod{
        id: id,
        type: type,
        account_number: fetch(attributes, "account_number"),
        account_type: fetch(attributes, "account_type"),
        institution_name: fetch(attributes, "institution_name"),
        payout_method_type: fetch(attributes, "payout_method_type"),
        routing_number: fetch(attributes, "routing_number"),
        verified_at: fetch_datetime(attributes, "verified_at"),
        created_at: fetch_datetime(attributes, "created_at"),
        updated_at: fetch_datetime(attributes, "updated_at"),
        # TODO: turn into formal relationship structs
        __relationships__: record["relationships"],
        # TODO: turn into formal links structs
        __links__: record["links"] || links,
        __raw__: record
      }

  def to_struct(
        %{
          "id" => id,
          "type" => "subscriptions" = type,
          "attributes" => attributes
        } = record,
        links
      ),
      do: %EPTSDK.Subscription{
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
        links
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
        # TODO: turn into formal relationship structs
        __relationships__: record["relationships"],
        # TODO: turn into formal links structs
        __links__: record["links"] || links,
        __raw__: record
      }

  def to_struct(
        %{
          "id" => id,
          "type" => "payouts" = type,
          "attributes" => attributes
        } = record,
        links
      ),
      do: %EPTSDK.Payout{
        id: id,
        type: type,
        amount_cents: fetch(attributes, "amount_cents"),
        amount_currency: fetch(attributes, "amount_currency"),
        fee_cents: fetch(attributes, "fee_cents"),
        fee_currency: fetch(attributes, "fee_currency"),
        net_amount_cents: fetch(attributes, "net_amount_cents"),
        net_amount_currency: fetch(attributes, "net_amount_currency"),
        processor_state: fetch(attributes, "processor_state"),
        transfer_credit_type: fetch(attributes, "transfer_credit_type"),
        created_at: fetch_datetime(attributes, "created_at"),
        updated_at: fetch_datetime(attributes, "updated_at"),
        # TODO: turn into formal relationship structs
        __relationships__: record["relationships"],
        # TODO: turn into formal links structs
        __links__: record["links"] || links,
        __raw__: record
      }

  def to_struct(record, links) when not is_map_key(record, "attributes") do
    to_struct(Map.put(record, "attributes", %{}), links)
  end

  defp fetch(attributes, key) when is_map(attributes) and is_binary(key) do
    if Map.has_key?(attributes, key) do
      attributes[key]
    else
      %EPTSDK.PropertyNotAvailable{property: key, reason: :unfetched}
    end
  end

  defp fetch_datetime(attributes, key) when is_map(attributes) and is_binary(key) do
    with true <- Map.has_key?(attributes, key),
         value <- Map.get(attributes, key),
         {:ok, timestamp} <- Timex.parse(value, "{ISO:Extended:Z}") do
      timestamp
    else
      nil -> nil
      false -> %EPTSDK.PropertyNotAvailable{property: key, reason: :unfetched}
      {:error, _message} -> %EPTSDK.PropertyNotAvailable{property: key, reason: :decoding_error}
    end
  end
end
