defmodule EPTSDK.PaymentSubscriptionsTest do
  use ExUnit.Case, async: true

  test "confirm/3 confirms a payment subscription by id" do
    id = "sub_123"
    stub_name = {__MODULE__, :confirm_id}

    Req.Test.stub(stub_name, fn conn ->
      assert conn.method == "PATCH"
      assert conn.request_path == "/payment_subscriptions/#{id}/confirm"

      {:ok, body, conn} = Plug.Conn.read_body(conn)

      assert Jason.decode!(body) == %{
               "data" => %{
                 "id" => id,
                 "type" => "payment_subscriptions",
                 "attributes" => %{}
               }
             }

      Req.Test.json(conn, %{
        "data" => %{
          "id" => id,
          "type" => "payment_subscriptions",
          "attributes" => %{"status" => "active"},
          "relationships" => %{},
          "links" => %{"self" => "https://api.tryedge.test:4001/v2/payment_subscriptions/#{id}"}
        }
      })
    end)

    assert {:ok, %EPTSDK.PaymentSubscriptions{id: ^id, status: "active"}, [], %EPTSDK{}} =
             EPTSDK.PaymentSubscriptions.confirm(stubbed_client(stub_name), id)
  end

  test "confirm/3 confirms a payment subscription by record" do
    id = "sub_456"
    stub_name = {__MODULE__, :confirm_record}

    Req.Test.stub(stub_name, fn conn ->
      assert conn.method == "PATCH"
      assert conn.request_path == "/payment_subscriptions/#{id}/confirm"

      Req.Test.json(conn, %{
        "data" => %{
          "id" => id,
          "type" => "payment_subscriptions",
          "attributes" => %{"status" => "ready"},
          "relationships" => %{},
          "links" => %{"self" => "https://api.tryedge.test:4001/v2/payment_subscriptions/#{id}"}
        }
      })
    end)

    payment_subscription = %EPTSDK.PaymentSubscriptions{
      id: id,
      type: "payment_subscriptions",
      __raw__: %{},
      __links__: %{}
    }

    assert {:ok, %EPTSDK.PaymentSubscriptions{id: ^id, status: "ready"}, [], %EPTSDK{}} =
             EPTSDK.PaymentSubscriptions.confirm(stubbed_client(stub_name), payment_subscription)
  end

  defp stubbed_client(stub_name) do
    EPTSDK.client(%{
      token: "token",
      user_agent: "user_agent",
      http_client: Req.new(plug: {Req.Test, stub_name})
    })
  end
end
