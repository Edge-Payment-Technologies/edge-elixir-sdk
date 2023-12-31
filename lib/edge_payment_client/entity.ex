defmodule EdgePaymentClient.Entity do
  def to_struct(
        %{
          "id" => id,
          "type" => "consumer_addresses",
          "attributes" => %{
            "line_1" => line_1,
            "city" => city,
            "state" => state,
            "zip" => zip,
            "country" => country,
            "created_at" => created_at,
            "updated_at" => updated_at
          }
        } = record,
        links
      ),
      do: %EdgePaymentClient.Address{
        id: id,
        type: "consumer_addresses",
        line_1: line_1,
        city: city,
        state: state,
        zip: zip,
        country: country,
        # TODO: Parse date time
        created_at: created_at,
        updated_at: updated_at,
        __relationships__: record["relationships"],
        __links__: record["links"] || links,
        __record__: record
      }

  def to_struct(
        %{
          "id" => id,
          "type" => "customers",
          "attributes" => %{
            "name" => name,
            "email" => email,
            "created_at" => created_at,
            "updated_at" => updated_at
          }
        } = record,
        links
      ),
      do: %EdgePaymentClient.Customer{
        id: id,
        type: "customers",
        name: name,
        email: email,
        # TODO: Parse date time
        created_at: created_at,
        updated_at: updated_at,
        __relationships__: record["relationships"],
        __links__: record["links"] || links,
        __record__: record
      }
end
