defmodule EPTSDK.ResourceTest do
  use ExUnit.Case
  doctest EPTSDK.Resource

  @data %{
    "data" => %{
      "attributes" => %{
        "description" => "Regular customer",
        "email" => "johnson@example.com",
        "created_at" => "2024-07-09T22:11:50.079276Z",
        "name" => "Johnson Parker",
        "phone_number" => nil,
        "updated_at" => "2024-07-09T22:11:50.079276Z"
      },
      "id" => "485262fd-54a2-48d9-829c-e34dbec8c7c3",
      "links" => %{
        "self" =>
          "https://api.tryedge.test:4001/api/v2/customers/485262fd-54a2-48d9-829c-e34dbec8c7c3"
      },
      "relationships" => %{
        "addresses" => %{
          "links" => %{
            "self" => "https://api.tryedge.test:4001/api/v2/customers/relationships/addresses"
          }
        },
        "merchant" => %{
          "data" => %{
            "id" => "b79287b9-a426-445b-a2e5-e646322c26cb",
            "type" => "merchants"
          },
          "links" => %{
            "self" => "https://api.tryedge.test:4001/api/v2/customers/relationships/merchant"
          }
        },
        "payment_demands" => %{
          "links" => %{
            "self" =>
              "https://api.tryedge.test:4001/api/v2/customers/relationships/payment_demands"
          }
        }
      },
      "type" => "customers"
    },
    "jsonapi" => %{"version" => "1.1"},
    "links" => %{
      "describedby" => "https://api.tryedge.test:4001/api/openapi",
      "self" => "https://api.tryedge.test:4001/api/v2/customers"
    },
    "meta" => %{
      "authors" => [
        "Ziyan Judaideen",
        "James Stuessy",
        "Amadeus Folego",
        "Kurtis Rainbolt-Greene"
      ],
      "copyright" => "2024 Edge Payment Technologies, Inc."
    }
  }

  test "from_payload/1" do
    assert match?(
             {:ok, %EPTSDK.Customer{}, [], %EPTSDK{}},
             EPTSDK.Resource.from_payload(
               {:ok, @data, EPTSDK.client(%{token: "token", user_agent: "user_agent"})}
             )
           )
  end
end
