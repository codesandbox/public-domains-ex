# Public Domains

_Quickly look up whether a domain hosts publicly-available email addresses._

## What is this?

When validating email addresses, it is sometimes useful to know whether the address is likely related to a company or comes from a publicly-accessible domain.
This library provides a [community-maintained list](https://gist.github.com/okutbay/5b4974b70673dfdcc21c517632c1f984) of domains that host publicly-available email addresses.
It is updated on an as-needed basis (pull requests welcome).

## Installation

This package is not available on Hex.pm, and should instead be downloaded directly from GitHub:

```elixir
def deps do
  [
    {:public_domains, github: "codesandbox/public-domains-ex"}
  ]
end
```

## Usage

TODO.

## Contributions

In order to update the list of domains, please run `./bin/update.sh` from the root of the project.
Then open a pull requests with the changes.
When possible, please do not mix domain list updates with other changes.
