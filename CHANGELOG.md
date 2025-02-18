# Changelog

## 10.0.0

- [breaking] sideload now can easily fit into the response from any `EPTSDK` api call instead of requiring a contorted series of steps
- [breaking] Now every api call returns `{:ok, resource_or_resources, included_list, client}` instead of the previous which didn't included the `included_list`.

## 9.0.0

- [breaking] Removing old relationships property now that we have codified results

## 8.0.1

- [bug] Two APIs still used includes, added tests to account for it.

## 8.0.0

- [breaking] [feature] Now relationships return the relation context (one to one or one to many)
- [breaking] No longer need the `included` list to be passed to structs
- [feature] New API `EPTSDK.sideload/3` which takes a list of records or record, an included list, and a list of things to load. This will replace the relationship structs with the actual relationships

## 7.0.0

- [breaking] Customers now have many addresses rather than one single address
- [breaking] We no longer automatically normalize relationships due to an infinite loop (fetch customers, include addresses, merchant, normalize customer -> addresses -> merchant -> addresses -> [...])
- [feature] You now have a reason for a relationship being unfetched

## 6.1.0

- [feature] You can now update a payment demand that isn't ready for processing

## 6.0.2

- [breaking] More changes to payment demand's interface

## 6.0.1

- [breaking] More changes to payment demand's interface
- [feature] Refund demands are now available

## 6.0.0

- [breaking] Payment demand has changed it's interface

## 5.0.2

- [fix] Removing an errant dbg() call.

## 5.0.1

- [fix] Update requests weren't sending the ID as part of the payload which is required by some JSONAPI servers.

## 5.0.0

- [breaking] With the new v2 endpoints we've officially moved away from the previous implementation. Not much has changed in terms of data, but a lot better naming:
  - charges to payment demand
  - refund demands split from charges
  - subscriptions to payment subscriptions
  - merchant accounts to merchants
  - users to accounts
- [breaking] We've also updated from a direct Finch integration to Req which has quickly become a community standard in Elixir. Instead of passing `finch_options`, you now pass an entire HTTP client. This also means we can drop the `json_encoder` and `json_decoder` options.
- [breaking] Allowing the usage of URIs for the `host` which is now called `location`

## 4.0.0

- [breaking] [business] We changed our domain name.

## 3.0.0

- [feature] Money properties now are parsed and we pulled more attributes over from charge
- [feature] Now when resource has a relationship we normalize it on the struct, for example `customer.address.merchant` will get you the merchant account of the consumer address of a customer.
- [breaking] [refactor] Rename `Address` to `ConsumerAddress`
- [breaking] [refactor] Renamed `property` property of PropertyNotFound to `name` as it reduces duplicitive naming.
- [breaking] [refactor] Removing `Dispute` because it isn't expressed in the HTTP API yet.
- [breaking] [refactor] The included values of a request are no longer stored on the `included` property of a `EPTSDK`

## 2.0.2

- [bugfix] Incorrectly parsing timestamps with the wrong ISO format.

## 2.0.1

- [bugfix] We weren't returning the type as part of the struct for resources
- [bugfix] Addresses didn't expose the `line_2` property

## 2.0.0

- [feature] [breaking] Now when the client recieves timestamps it will parse them with ISO Basic (8601).
- [feature] Fully fleshed out a ton more resources with their properties (to many to name)
- [feature] PropertyNotAvailable will now have a reason property that tells you why it is not available, as there are two reasons: unfetched and decoding error.

## 1.0.1

- [bugfix] When a request resulted in an error, like a timeout, it would fail in the middle of the library

## 1.0.0

- First release of the library
