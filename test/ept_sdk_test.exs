defmodule EPTSDKTest do
  use ExUnit.Case
  doctest EPTSDK

  test "instantiating a new client" do
    assert match?(
             %EPTSDK{
               authorization: "Bearer sk_sandbox_ZZxeMuuV5fc3LevKmCvHSq5G"
             },
             EPTSDK.client(%{
               token: "sk_sandbox_ZZxeMuuV5fc3LevKmCvHSq5G"
             })
           )
  end
end
