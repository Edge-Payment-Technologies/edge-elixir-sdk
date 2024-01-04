# Changelog

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
