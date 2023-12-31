defmodule EdgePaymentClient.Entity do
  @spec to_struct(
          map(),
          map() | nil
        ) :: EdgePaymentClient.Address.t() | EdgePaymentClient.Customer.t()
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
        __record__: record
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
        __relationships__: record["relationships"],
        __links__: record["links"] || links,
        __record__: record
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
