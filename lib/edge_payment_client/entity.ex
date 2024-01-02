defmodule EdgePaymentClient.Entity do
  @moduledoc """
  An individual record from the Edge API.
  """
  def to_struct(
        %{
          "id" => id,
          "type" => "payment_methods",
          "attributes" => attributes
        } = record,
        links
      ),
      do: %EdgePaymentClient.PaymentMethod{
        id: id,
        card_pan_token: fetch(attributes, "card_pan_token"),
        card_cvv_token: fetch(attributes, "card_cvv_token"),
        expiry_month: fetch(attributes, "expiry_month"),
        expiry_year: fetch(attributes, "expiry_year"),
        # TODO: Parse date time
        created_at: fetch(attributes, "created_at"),
        updated_at: fetch(attributes, "updated_at"),
        __relationships__: record["relationships"],
        __links__: record["links"] || links,
        __raw__: record
      }

  def to_struct(
        %{
          "id" => id,
          "type" => "charges",
          "attributes" => attributes
        } = record,
        links
      ),
      do: %EdgePaymentClient.Charge{
        id: id,
        amount_cents: fetch(attributes, "amount_cents"),
        currency: fetch(attributes, "currency"),
        description: fetch(attributes, "description"),
        # TODO: Parse date time
        created_at: fetch(attributes, "created_at"),
        updated_at: fetch(attributes, "updated_at"),
        __relationships__: record["relationships"],
        __links__: record["links"] || links,
        __raw__: record
      }

  def to_struct(
        %{
          "id" => id,
          "type" => "consumer_addresses",
          "attributes" => attributes
        } = record,
        links
      ),
      do: %EdgePaymentClient.Address{
        id: id,
        line_1: fetch(attributes, "line_1"),
        city: fetch(attributes, "city"),
        state: fetch(attributes, "state"),
        zip: fetch(attributes, "zip"),
        country: fetch(attributes, "country"),
        # TODO: Parse date time
        created_at: fetch(attributes, "created_at"),
        updated_at: fetch(attributes, "updated_at"),
        __relationships__: record["relationships"],
        __links__: record["links"] || links,
        __raw__: record
      }

  def to_struct(
        %{
          "id" => id,
          "type" => "customers",
          "attributes" => attributes
        } = record,
        links
      ),
      do: %EdgePaymentClient.Customer{
        id: id,
        name: fetch(attributes, "name"),
        email: fetch(attributes, "email"),
        # TODO: Parse date time
        created_at: fetch(attributes, "created_at"),
        updated_at: fetch(attributes, "updated_at"),
        # TODO: turn into formal relationship structs
        __relationships__: record["relationships"],
        # TODO: turn into formal links structs
        __links__: record["links"] || links,
        __raw__: record
      }
  def to_struct(
        %{
          "id" => id,
          "type" => "merchant_accounts",
          "attributes" => attributes
        } = record,
        links
      ),
      do: %EdgePaymentClient.MerchantAccount{
        id: id,
        business_name: fetch(attributes, "business_name"),
        # TODO: Parse date time
        created_at: fetch(attributes, "created_at"),
        updated_at: fetch(attributes, "updated_at"),
        # TODO: turn into formal relationship structs
        __relationships__: record["relationships"],
        # TODO: turn into formal links structs
        __links__: record["links"] || links,
        __raw__: record
      }
  def to_struct(
        %{
          "id" => id,
          "type" => "events",
          "attributes" => attributes
        } = record,
        links
      ),
      do: %EdgePaymentClient.Event{
        id: id,
        # TODO: Parse date time
        created_at: fetch(attributes, "created_at"),
        # TODO: turn into formal relationship structs
        __relationships__: record["relationships"],
        # TODO: turn into formal links structs
        __links__: record["links"] || links,
        __raw__: record
      }
  def to_struct(
        %{
          "id" => id,
          "type" => "disputes",
          "attributes" => attributes
        } = record,
        links
      ),
      do: %EdgePaymentClient.Dispute{
        id: id,
        # TODO: Parse date time
        created_at: fetch(attributes, "created_at"),
        updated_at: fetch(attributes, "updated_at"),
        # TODO: turn into formal relationship structs
        __relationships__: record["relationships"],
        # TODO: turn into formal links structs
        __links__: record["links"] || links,
        __raw__: record
      }
  def to_struct(
        %{
          "id" => id,
          "type" => "payout_methods",
          "attributes" => attributes
        } = record,
        links
      ),
      do: %EdgePaymentClient.PayoutMethod{
        id: id,
        # TODO: Parse date time
        created_at: fetch(attributes, "created_at"),
        updated_at: fetch(attributes, "updated_at"),
        # TODO: turn into formal relationship structs
        __relationships__: record["relationships"],
        # TODO: turn into formal links structs
        __links__: record["links"] || links,
        __raw__: record
      }
  def to_struct(
        %{
          "id" => id,
          "type" => "subscriptions",
          "attributes" => attributes
        } = record,
        links
      ),
      do: %EdgePaymentClient.Subscription{
        id: id,
        # TODO: Parse date time
        created_at: fetch(attributes, "created_at"),
        updated_at: fetch(attributes, "updated_at"),
        # TODO: turn into formal relationship structs
        __relationships__: record["relationships"],
        # TODO: turn into formal links structs
        __links__: record["links"] || links,
        __raw__: record
      }
  def to_struct(
        %{
          "id" => id,
          "type" => "webhook_deliveries",
          "attributes" => attributes
        } = record,
        links
      ),
      do: %EdgePaymentClient.WebhookDelivery{
        id: id,
        # TODO: Parse date time
        created_at: fetch(attributes, "created_at"),
        updated_at: fetch(attributes, "updated_at"),
        # TODO: turn into formal relationship structs
        __relationships__: record["relationships"],
        # TODO: turn into formal links structs
        __links__: record["links"] || links,
        __raw__: record
      }
  def to_struct(
        %{
          "id" => id,
          "type" => "webhook_subscriptions",
          "attributes" => attributes
        } = record,
        links
      ),
      do: %EdgePaymentClient.WebhookSubscription{
        id: id,
        # TODO: Parse date time
        created_at: fetch(attributes, "created_at"),
        updated_at: fetch(attributes, "updated_at"),
        # TODO: turn into formal relationship structs
        __relationships__: record["relationships"],
        # TODO: turn into formal links structs
        __links__: record["links"] || links,
        __raw__: record
      }

  def to_struct(record, links) when not is_map_key(record, "attributes") do
    to_struct(Map.put(record, "attributes", %{}), links)
  end

  defp fetch(attributes, key) do
    if Map.has_key?(attributes, key) do
      attributes[key]
    else
      %EdgePaymentClient.PropertyNotAvailable{property: key}
    end
  end
end
