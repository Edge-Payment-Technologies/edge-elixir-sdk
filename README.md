# EdgePaymentClient

A SDK (software development kit) for interacting with the [Edge Payment Technologies, Inc](https://tryedge.com) HTTP API.


## Using

In order to use the SDK you need two things:

1. A merchant account with Edge Payment Technologies with a minimum amount of business information.
2. A sandbox or production private key from the dashboard.

Once you have those two things you need to instantiate a client. This client can be used for multiple requests. The only two required parameters for a client are the `token` and `user_agent`. The former is used for authenticating your requests and the latter is used for identifying your usage. User Agent identity helps us find clients that aren't behaving correctly and communicate with their owner. You can read more here https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/User-Agent and https://docs.newrelic.com/docs/apis/rest-api-v2/basic-functions/set-custom-user-agent/

``` elixir
client = EdgePaymentClient.client(%{
  token: "sk_sandbox_VUNVkopDczZcr1oJPLPAGfrN",
  user_agent: "BigShoeApp/1.0"
})
```

We can now use that client to make requests:

``` elixir
customerA = client
|> EdgePaymentClient.Customer.create(%{
  name: "Johnson"
})
```

``` elixir
customerB = client
|> EdgePaymentClient.Customer.list(
  %{name: "test"},
  ["address"],
  ["name"]
)
|> List.first()
```

``` elixir
customerA == customerB

```

``` elixir
client
|> EdgePaymentClient.Customer.update(customer, %{
  name: "Sally"
})
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `edge_payment_client` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:edge_payment_client, "~> 1.0.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/edge_payment_client>.
