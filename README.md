# EPTSDK

A SDK (software development kit) for interacting with the [Edge Payment Technologies, Inc](https://tryedge.io) HTTP API.

## Using

In order to use the SDK you need two things:

1. A merchant with Edge Payment Technologies with a minimum amount of business information.
2. A sandbox or production private key from the dashboard.

Once you have those two things you need to instantiate a client. This client can be used for multiple requests. The only two required parameters for a client are the `token` and `user_agent`. The former is used for authenticating your requests and the latter is used for identifying your usage. User Agent identity helps us find clients that aren't behaving correctly and communicate with their owner. You can read more here https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/User-Agent and https://docs.newrelic.com/docs/apis/rest-api-v2/basic-functions/set-custom-user-agent/

```elixir
client = EPTSDK.client(%{
  token: "ept_sandbox_sQsnYGFoLvE2Qt7tmsvuDESB2TBBA2wf1UfQruzmenG14tTMHb",
  user_agent: "BigShoeApp/1.0",
})
```

We can now use that client to make requests:

```elixir
{:ok, customerA, [], client} = EPTSDK.Customer.create(client, attributes: %{
    name: "Johnson Parker",
    email: "johnson@example.com"
  })
```

```elixir
{:ok, customerB, included, client} = client
  |> EPTSDK.Customer.list(
    filter: %{name: "Johnson Parker"},
    include: ["address"],
    sort: ["name"],
    fields: %{customers: ["name"]}
  )
  |> List.first()
```

```elixir
customerA == customerB

```

```elixir
{:ok, customerA, [], client} = EPTSDK.Customer.update(client, customerA, attributes: %{
  name: "Sally"
})
```

## Payment subscription proration

When you create or confirm a payment subscription with `proration_behavior: :create_prorations`
and a future `billing_cycle_anchor_at`, Edge creates an immediate prorated first charge for the
remaining portion of the current billing period.

The billing anchor is still preserved, so the first full recurring charge is collected on
`billing_cycle_anchor_at`.

When `proration_behavior: :none`, Edge does not create an immediate prorated charge. The first
charge is delayed until the billing anchor and is billed as a full cycle.

```elixir
{:ok, payment_subscription, [], client} =
  EPTSDK.PaymentSubscription.create(client,
    attributes: %{
      amount_cents: 15_000,
      amount_currency: :USD,
      billing_period: :one_month,
      billing_cycle_anchor_at: ~U[2030-02-01 00:00:00Z],
      proration_behavior: :create_prorations
    }
  )

{:ok, confirmed_subscription, [], client} =
  EPTSDK.PaymentSubscription.confirm(client, payment_subscription)
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ept_sdk` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ept_sdk, "~> 10.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ept_sdk>.
