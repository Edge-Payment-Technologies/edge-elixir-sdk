defmodule EdgePaymentClientTest do
  use ExUnit.Case
  doctest EdgePaymentClient

  test "instantiating a new client" do
    assert match?(%EdgePaymentClient{
      authorization: "Bearer sk_sandbox_ZZxeMuuV5fc3LevKmCvHSq5G"
    }, EdgePaymentClient.client(%{
      token: "sk_sandbox_ZZxeMuuV5fc3LevKmCvHSq5G"
    }))
  end
end
