defmodule EPTSDKTest do
  use ExUnit.Case
  doctest EPTSDK

  @included [
    %{
      "attributes" => %{
        "city" => "Portland",
        "country" => "USA",
        "created_at" => "2024-01-16T17:34:44.403Z",
        "discarded_at" => nil,
        "line_1" => "58050 Los Calamos Ave.",
        "line_2" => nil,
        "state" => "OR",
        "updated_at" => "2024-01-16T17:34:44.403Z",
        "zip" => "90112"
      },
      "id" => "573b18f8-140e-4983-95b6-7b031b35ed37",
      "links" => %{
        "self" => "http://localhost:3000/consumer_addresses/573b18f8-140e-4983-95b6-7b031b35ed37"
      },
      "relationships" => %{
        "merchant" => %{
          "data" => %{
            "id" => "a2356d28-8b4e-48bf-a834-2e37ae37e813",
            "type" => "merchants"
          },
          "links" => %{
            "related" =>
              "http://localhost:3000/consumer_addresses/573b18f8-140e-4983-95b6-7b031b35ed37/merchant",
            "self" =>
              "http://localhost:3000/consumer_addresses/573b18f8-140e-4983-95b6-7b031b35ed37/relationships/merchant"
          }
        }
      },
      "type" => "consumer_addresses"
    },
    %{
      "attributes" => %{
        "active_at" => "2024-01-13T17:19:01.000Z",
        "average_monthly_transaction_volume_cents" => 1_000_000_000,
        "average_transaction_size_cents" => 100_000,
        "business_address" => "6010 S Celedon Creek",
        "business_address_line_2" => "",
        "business_city_name" => "Playa Vista",
        "business_country" => "USA",
        "business_description" => "Edge root test account",
        "business_name" => "Edge",
        "business_privacy_url" => "https://www.tryedge.io/privacy",
        "business_state" => "California",
        "business_support_email" => "support@tryedge.io",
        "business_support_url" => "https://www.tryedge.io/support",
        "business_terms_url" => "https://www.tryedge.io/terms",
        "business_timezone" => "UTC",
        "business_website" => "https://www.tryedge.io",
        "business_zip_code" => "90094",
        "created_at" => "2024-01-16T17:19:03.517Z",
        "manual_review_at" => nil,
        "max_transaction_size_cents" => 10_000_000,
        "pending_at" => nil,
        "phone_number" => "+13107484186",
        "public_business_name" => "Edge",
        "shortened_descriptor" => "pymts",
        "statement_descriptor" => "EDGEPYMTS",
        "updated_at" => "2024-01-16T17:19:05.787Z"
      },
      "id" => "a2356d28-8b4e-48bf-a834-2e37ae37e813",
      "links" => %{
        "self" => "http://localhost:3000/merchants/a2356d28-8b4e-48bf-a834-2e37ae37e813"
      },
      "relationships" => %{
        "payment_demands" => %{
          "links" => %{
            "related" =>
              "http://localhost:3000/merchants/a2356d28-8b4e-48bf-a834-2e37ae37e813/payment_demands",
            "self" =>
              "http://localhost:3000/merchants/a2356d28-8b4e-48bf-a834-2e37ae37e813/relationships/payment_demands"
          }
        },
        "consumer_addresses" => %{
          "data" => [
            %{
              "id" => "573b18f8-140e-4983-95b6-7b031b35ed37",
              "type" => "consumer_addresses"
            }
          ],
          "links" => %{
            "related" =>
              "http://localhost:3000/merchants/a2356d28-8b4e-48bf-a834-2e37ae37e813/consumer_addresses",
            "self" =>
              "http://localhost:3000/merchants/a2356d28-8b4e-48bf-a834-2e37ae37e813/relationships/consumer_addresses"
          }
        },
        "customers" => %{
          "data" => [
            %{
              "id" => "565e6a1f-4038-485c-81d8-0f6fb121ee91",
              "type" => "customers"
            }
          ],
          "links" => %{
            "related" =>
              "http://localhost:3000/merchants/a2356d28-8b4e-48bf-a834-2e37ae37e813/customers",
            "self" =>
              "http://localhost:3000/merchants/a2356d28-8b4e-48bf-a834-2e37ae37e813/relationships/customers"
          }
        },
        "events" => %{
          "data" => [
            %{
              "id" => "609286c2-9e29-41bd-8810-b5feb63a5cf5",
              "type" => "events"
            },
            %{
              "id" => "74ccf77b-11de-427a-aae2-367d8b0762d8",
              "type" => "events"
            },
            %{
              "id" => "d39f0318-9a9f-4454-8c3b-4f41cc25fa7e",
              "type" => "events"
            },
            %{
              "id" => "a3e9506b-b7d8-4f5a-b635-bbd13b927b5e",
              "type" => "events"
            },
            %{
              "id" => "ca915a3b-4bb9-4b2e-bb1c-8cc27aa0f736",
              "type" => "events"
            },
            %{
              "id" => "3a52b97a-8541-4773-b261-a9757376012f",
              "type" => "events"
            },
            %{
              "id" => "61856eda-18b6-43ec-85fd-e4fbf3d5f584",
              "type" => "events"
            }
          ],
          "links" => %{
            "related" =>
              "http://localhost:3000/merchants/a2356d28-8b4e-48bf-a834-2e37ae37e813/events",
            "self" =>
              "http://localhost:3000/merchants/a2356d28-8b4e-48bf-a834-2e37ae37e813/relationships/events"
          }
        },
        "payment_methods" => %{
          "links" => %{
            "related" =>
              "http://localhost:3000/merchants/a2356d28-8b4e-48bf-a834-2e37ae37e813/payment_methods",
            "self" =>
              "http://localhost:3000/merchants/a2356d28-8b4e-48bf-a834-2e37ae37e813/relationships/payment_methods"
          }
        },
        "payment_subscriptions" => %{
          "links" => %{
            "related" =>
              "http://localhost:3000/merchants/a2356d28-8b4e-48bf-a834-2e37ae37e813/payment_subscriptions",
            "self" =>
              "http://localhost:3000/merchants/a2356d28-8b4e-48bf-a834-2e37ae37e813/relationships/payment_subscriptions"
          }
        },
        "webhook_subscriptions" => %{
          "links" => %{
            "related" =>
              "http://localhost:3000/merchants/a2356d28-8b4e-48bf-a834-2e37ae37e813/webhook_subscriptions",
            "self" =>
              "http://localhost:3000/merchants/a2356d28-8b4e-48bf-a834-2e37ae37e813/relationships/webhook_subscriptions"
          }
        }
      },
      "type" => "merchants"
    }
  ]

  @data %EPTSDK.Customer{
    id: "565e6a1f-4038-485c-81d8-0f6fb121ee91",
    type: "customers",
    name: "Johnson Sable 58050",
    email: "john+58050@example.com",
    phone_number: nil,
    discarded_at: nil,
    blocked_at: nil,
    created_at: ~U[2024-01-16 17:24:38Z],
    updated_at: ~U[2024-01-16 17:35:11Z],
    addresses: %EPTSDK.Relationship{
      name: "addresses",
      has: :many,
      data: [
        %{
          id: "573b18f8-140e-4983-95b6-7b031b35ed37",
          type: "consumer_addresses"
        }
      ]
    },
    payment_methods: %EPTSDK.RelationshipNotAvailable{
      name: "payment_methods",
      reason: :unfetched
    },
    payment_demands: %EPTSDK.RelationshipNotAvailable{
      name: "payment_demands",
      reason: :unfetched
    },
    merchant: %EPTSDK.RelationshipNotAvailable{
      name: "merchant",
      reason: :undefined_relationship
    },
    __raw__: %{},
    __links__: %{}
  }

  test "sideload/3" do
    assert match?(
             {:ok, %EPTSDK.Customer{addresses: [%EPTSDK.ConsumerAddress{}]}, [_ | _], %EPTSDK{}},
             EPTSDK.sideload(
               {:ok, @data, @included,
                EPTSDK.client(%{token: "token", user_agent: "user_agent"})},
               [:addresses]
             )
           )
  end

  test "client/1" do
    assert match?(
             %EPTSDK{
               authorization: "Bearer sk_sandbox_ZZxeMuuV5fc3LevKmCvHSq5G",
               user_agent: "HAL/1.0"
             },
             EPTSDK.client(%{
               token: "sk_sandbox_ZZxeMuuV5fc3LevKmCvHSq5G",
               user_agent: "HAL/1.0"
             })
           )
  end
end
