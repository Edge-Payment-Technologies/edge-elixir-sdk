defmodule EPTSDKTest do
  use ExUnit.Case
  doctest EPTSDK

  @included [
    %{
      "attributes" => %{
        "account_status" => "active",
        "active_at" => "2024-06-10T00:08:41.492654Z",
        "business_description" =>
          "We're building payments infrastructure for merchants who are mislabeled as high-risk.",
        "business_email" => "dega@tryedge.io",
        "business_name" => "Edge",
        "business_support_email" => "support@tryedge.io",
        "business_support_url" => "https://www.tryedge.io/support",
        "business_terms_url" => "https://www.tryedge.io/terms",
        "business_timezone" => "UTC",
        "business_website" => "https://www.tryedge.io",
        "business_zip_code" => "90232",
        "category_code" => "5045",
        "created_at" => "2024-06-01T00:08:41.492654Z",
        "entity_type" => "private_ccorporation",
        "phone_number" => "+13233883931",
        "prior_bankruptcies" => false,
        "tax_id_type" => "ein",
        "updated_at" => "2025-04-10T00:08:41.492654Z"
      },
      "id" => "5c83409a-f8c2-40ae-ad4c-fd721c114750",
      "links" => %{
        "self" =>
          "https://api.tryedge.test:4001/v2/payment_demands/5c83409a-f8c2-40ae-ad4c-fd721c114750"
      },
      "relationships" => %{
        "beneficial_owners" => %{
          "links" => %{
            "self" =>
              "https://api.tryedge.test:4001/v2/payment_demands/5c83409a-f8c2-40ae-ad4c-fd721c114750/relationships/beneficial_owners"
          }
        },
        "corporate_officials" => %{
          "links" => %{
            "self" =>
              "https://api.tryedge.test:4001/v2/payment_demands/5c83409a-f8c2-40ae-ad4c-fd721c114750/relationships/corporate_officials"
          }
        },
        "customers" => %{
          "links" => %{
            "self" =>
              "https://api.tryedge.test:4001/v2/payment_demands/5c83409a-f8c2-40ae-ad4c-fd721c114750/relationships/customers"
          }
        },
        "payment_demands" => %{
          "links" => %{
            "self" =>
              "https://api.tryedge.test:4001/v2/payment_demands/5c83409a-f8c2-40ae-ad4c-fd721c114750/relationships/payment_demands"
          }
        },
        "payment_methods" => %{
          "links" => %{
            "self" =>
              "https://api.tryedge.test:4001/v2/payment_demands/5c83409a-f8c2-40ae-ad4c-fd721c114750/relationships/payment_methods"
          }
        }
      },
      "type" => "merchants"
    },
    %{
      "attributes" => %{
        "city" => "New Savion",
        "country" => "USA",
        "created_at" => "2025-04-10T00:08:41.492654Z",
        "discarded_at" => nil,
        "line_1" => "73234 Obie Fields",
        "line_2" => nil,
        "state" => "FL",
        "status" => "immutable",
        "updated_at" => "2025-08-31T00:08:41.458810Z",
        "zip" => "81933"
      },
      "id" => "56b4ba75-d039-4cba-b479-2ef937918c4e",
      "links" => %{
        "self" =>
          "https://api.tryedge.test:4001/v2/payment_demands/56b4ba75-d039-4cba-b479-2ef937918c4e"
      },
      "relationships" => %{
        "customer" => %{
          "data" => %{
            "id" => "c6919dd4-0fc4-4e7e-8c24-b0f645d44e2d",
            "type" => "customers"
          },
          "links" => %{
            "self" =>
              "https://api.tryedge.test:4001/v2/payment_demands/56b4ba75-d039-4cba-b479-2ef937918c4e/relationships/customer"
          }
        },
        "merchant" => %{
          "data" => %{
            "id" => "5c83409a-f8c2-40ae-ad4c-fd721c114750",
            "type" => "merchants"
          },
          "links" => %{
            "self" =>
              "https://api.tryedge.test:4001/v2/payment_demands/56b4ba75-d039-4cba-b479-2ef937918c4e/relationships/merchant"
          }
        }
      },
      "type" => "consumer_addresses"
    },
    %{
      "attributes" => %{
        "city" => "New Savion",
        "country" => "USA",
        "created_at" => "2025-04-10T00:08:41.492654Z",
        "discarded_at" => nil,
        "line_1" => "73234 Obie Fields",
        "line_2" => nil,
        "state" => "FL",
        "status" => "immutable",
        "updated_at" => "2025-08-31T00:08:41.458810Z",
        "zip" => "81933"
      },
      "id" => "56b4ba75-d039-4cba-b479-2ef937918c4e",
      "links" => %{
        "self" =>
          "https://api.tryedge.test:4001/v2/payment_demands/56b4ba75-d039-4cba-b479-2ef937918c4e"
      },
      "relationships" => %{
        "customer" => %{
          "data" => %{
            "id" => "c6919dd4-0fc4-4e7e-8c24-b0f645d44e2d",
            "type" => "customers"
          },
          "links" => %{
            "self" =>
              "https://api.tryedge.test:4001/v2/payment_demands/56b4ba75-d039-4cba-b479-2ef937918c4e/relationships/customer"
          }
        },
        "merchant" => %{
          "data" => %{
            "id" => "5c83409a-f8c2-40ae-ad4c-fd721c114750",
            "type" => "merchants"
          },
          "links" => %{
            "self" =>
              "https://api.tryedge.test:4001/v2/payment_demands/56b4ba75-d039-4cba-b479-2ef937918c4e/relationships/merchant"
          }
        }
      },
      "type" => "consumer_addresses"
    }
  ]

  @data %EPTSDK.PaymentDemand{
    id: "f52985bd-d8a3-4186-a70f-c9505dfc124c",
    type: "payment_demands",
    amount: %Money{amount: 25242, currency: :USD},
    amount_cents: 25242,
    amount_currency: "USD",
    payer_timezone: "America/Los_Angeles",
    fee: %Money{amount: 1033, currency: :USD},
    fee_cents: 1033,
    description: nil,
    idempotency_key: "66e5a001-e3d9-4f99-af8c-715527d62d0f",
    processor_state: :succeeded,
    created_at: ~U[2025-08-31 00:08:41.458810Z],
    updated_at: ~U[2025-04-10 00:08:41.492654Z],
    merchant: %EPTSDK.Relationship{
      name: "merchant",
      data: %{id: "5c83409a-f8c2-40ae-ad4c-fd721c114750", type: "merchants"},
      has: :one
    },
    buyer: %EPTSDK.Relationship{
      name: "buyer",
      data: %{id: "c6919dd4-0fc4-4e7e-8c24-b0f645d44e2d", type: "customers"},
      has: :one
    },
    receiver: %EPTSDK.Relationship{
      name: "receiver",
      data: %{id: "c6919dd4-0fc4-4e7e-8c24-b0f645d44e2d", type: "customers"},
      has: :one
    },
    payer: %EPTSDK.Relationship{
      name: "payer",
      data: %{id: "c6919dd4-0fc4-4e7e-8c24-b0f645d44e2d", type: "customers"},
      has: :one
    },
    payment_method: %EPTSDK.Relationship{
      name: "payment_method",
      data: %{id: "71570f7e-f9ec-4e89-9a6b-b1cfff2d5342", type: "payment_methods"},
      has: :one
    },
    billing_address: %EPTSDK.Relationship{
      name: "billing_address",
      data: %{
        id: "56b4ba75-d039-4cba-b479-2ef937918c4e",
        type: "consumer_addresses"
      },
      has: :one
    },
    payment_subscription: %EPTSDK.RelationshipNotAvailable{
      name: "payment_subscription",
      reason: :undefined
    },
    shipping_address: %EPTSDK.Relationship{
      name: "shipping_address",
      data: %{
        id: "56b4ba75-d039-4cba-b479-2ef937918c4e",
        type: "consumer_addresses"
      },
      has: :one
    },
    __raw__: %{
      "attributes" => %{
        "amount_cents" => 25242,
        "amount_currency" => "USD",
        "capture_method" => "automatic",
        "created_at" => "2025-08-31T00:08:41.458810Z",
        "description" => nil,
        "fee_cents" => 1033,
        "idempotency_key" => "66e5a001-e3d9-4f99-af8c-715527d62d0f",
        "payer_timezone" => "America/Los_Angeles",
        "processor_state" => "succeeded",
        "succeeded_at" => "2025-04-10T00:08:41.492654Z",
        "updated_at" => "2025-04-10T00:08:41.492654Z"
      },
      "id" => "f52985bd-d8a3-4186-a70f-c9505dfc124c",
      "links" => %{
        "self" =>
          "https://api.tryedge.test:4001/v2/payment_demands/f52985bd-d8a3-4186-a70f-c9505dfc124c"
      },
      "relationships" => %{
        "billing_address" => %{
          "data" => %{
            "id" => "56b4ba75-d039-4cba-b479-2ef937918c4e",
            "type" => "consumer_addresses"
          },
          "links" => %{
            "self" =>
              "https://api.tryedge.test:4001/v2/payment_demands/f52985bd-d8a3-4186-a70f-c9505dfc124c/relationships/billing_address"
          }
        },
        "buyer" => %{
          "data" => %{
            "id" => "c6919dd4-0fc4-4e7e-8c24-b0f645d44e2d",
            "type" => "customers"
          },
          "links" => %{
            "self" =>
              "https://api.tryedge.test:4001/v2/payment_demands/f52985bd-d8a3-4186-a70f-c9505dfc124c/relationships/buyer"
          }
        },
        "merchant" => %{
          "data" => %{
            "id" => "5c83409a-f8c2-40ae-ad4c-fd721c114750",
            "type" => "merchants"
          },
          "links" => %{
            "self" =>
              "https://api.tryedge.test:4001/v2/payment_demands/f52985bd-d8a3-4186-a70f-c9505dfc124c/relationships/merchant"
          }
        },
        "payer" => %{
          "data" => %{
            "id" => "c6919dd4-0fc4-4e7e-8c24-b0f645d44e2d",
            "type" => "customers"
          },
          "links" => %{
            "self" =>
              "https://api.tryedge.test:4001/v2/payment_demands/f52985bd-d8a3-4186-a70f-c9505dfc124c/relationships/payer"
          }
        },
        "payment_method" => %{
          "data" => %{
            "id" => "71570f7e-f9ec-4e89-9a6b-b1cfff2d5342",
            "type" => "payment_methods"
          },
          "links" => %{
            "self" =>
              "https://api.tryedge.test:4001/v2/payment_demands/f52985bd-d8a3-4186-a70f-c9505dfc124c/relationships/payment_method"
          }
        },
        "receiver" => %{
          "data" => %{
            "id" => "c6919dd4-0fc4-4e7e-8c24-b0f645d44e2d",
            "type" => "customers"
          },
          "links" => %{
            "self" =>
              "https://api.tryedge.test:4001/v2/payment_demands/f52985bd-d8a3-4186-a70f-c9505dfc124c/relationships/receiver"
          }
        },
        "shipping_address" => %{
          "data" => %{
            "id" => "56b4ba75-d039-4cba-b479-2ef937918c4e",
            "type" => "consumer_addresses"
          },
          "links" => %{
            "self" =>
              "https://api.tryedge.test:4001/v2/payment_demands/f52985bd-d8a3-4186-a70f-c9505dfc124c/relationships/shipping_address"
          }
        }
      },
      "type" => "payment_demands"
    },
    __links__: %{
      "self" =>
        "https://api.tryedge.test:4001/v2/payment_demands/f52985bd-d8a3-4186-a70f-c9505dfc124c"
    }
  }

  test "sideload/3" do
    assert match?(
             {:ok, %EPTSDK.PaymentDemand{}, [_ | _], %EPTSDK{}},
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
