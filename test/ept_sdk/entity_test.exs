defmodule EPTSDK.EncoderTest do
  use ExUnit.Case
  doctest EPTSDK.Encoder

  @data %{
    "attributes" => %{
      "blocked_at" => nil,
      "created_at" => "2024-01-16T17:24:38Z",
      "description" => "Regular customer",
      "discarded_at" => nil,
      "email" => "john+58050@example.com",
      "name" => "Johnson Sable 58050",
      "phone_number" => nil,
      "updated_at" => "2024-01-16T17:35:11Z"
    },
    "id" => "565e6a1f-4038-485c-81d8-0f6fb121ee91",
    "links" => %{
      "self" => "http://localhost:3000/customers/565e6a1f-4038-485c-81d8-0f6fb121ee91"
    },
    "relationships" => %{
      "addresses" => %{
        "data" => [
          %{
            "id" => "573b18f8-140e-4983-95b6-7b031b35ed37",
            "type" => "consumer_addresses"
          }
        ],
        "links" => %{
          "related" =>
            "http://localhost:3000/customers/565e6a1f-4038-485c-81d8-0f6fb121ee91/address",
          "self" =>
            "http://localhost:3000/customers/565e6a1f-4038-485c-81d8-0f6fb121ee91/relationships/address"
        }
      },
      "payment_demands" => %{
        "links" => %{
          "related" =>
            "http://localhost:3000/customers/565e6a1f-4038-485c-81d8-0f6fb121ee91/payment_demands",
          "self" =>
            "http://localhost:3000/customers/565e6a1f-4038-485c-81d8-0f6fb121ee91/relationships/payment_demands"
        }
      },
      "payment_methods" => %{
        "links" => %{
          "related" =>
            "http://localhost:3000/customers/565e6a1f-4038-485c-81d8-0f6fb121ee91/payment_methods",
          "self" =>
            "http://localhost:3000/customers/565e6a1f-4038-485c-81d8-0f6fb121ee91/relationships/payment_methods"
        }
      },
      "published_events" => %{
        "data" => [
          %{"id" => "3a52b97a-8541-4773-b261-a9757376012f", "type" => "events"},
          %{"id" => "61856eda-18b6-43ec-85fd-e4fbf3d5f584", "type" => "events"}
        ],
        "links" => %{
          "related" =>
            "http://localhost:3000/customers/565e6a1f-4038-485c-81d8-0f6fb121ee91/published_events",
          "self" =>
            "http://localhost:3000/customers/565e6a1f-4038-485c-81d8-0f6fb121ee91/relationships/published_events"
        }
      },
      "payment_subscriptions" => %{
        "links" => %{
          "related" =>
            "http://localhost:3000/customers/565e6a1f-4038-485c-81d8-0f6fb121ee91/payment_subscriptions",
          "self" =>
            "http://localhost:3000/customers/565e6a1f-4038-485c-81d8-0f6fb121ee91/relationships/payment_subscriptions"
        }
      }
    },
    "type" => "customers"
  }

  test "when handling a customer it normalizes the associated and included address, payment method, and merchant" do
    assert match?(
             %EPTSDK.Customer{
               id: "565e6a1f-4038-485c-81d8-0f6fb121ee91",
               addresses: %EPTSDK.Relationship{
                 has: :many,
                 name: "addresses",
                 data: [
                   %{
                     id: "573b18f8-140e-4983-95b6-7b031b35ed37",
                     type: "consumer_addresses"
                   }
                 ]
               },
               merchant: %EPTSDK.RelationshipNotAvailable{
                 name: "merchant",
                 reason: :undefined_relationship
               },
               payment_methods: %EPTSDK.RelationshipNotAvailable{
                 name: "payment_methods",
                 reason: :unfetched
               },
               created_at: %DateTime{},
               updated_at: %DateTime{}
             },
             EPTSDK.Encoder.to_struct(
               @data,
               %{
                 "self" => "http://localhost:3000/customers/565e6a1f-4038-485c-81d8-0f6fb121ee91"
               }
             )
           )
  end
end
