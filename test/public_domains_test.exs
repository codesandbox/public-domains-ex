defmodule PublicDomainsTest do
  use ExUnit.Case

  setup_all do
    PublicDomains.cache_domain_list()
  end

  describe "public?/1" do
    test "returns whether a domain is public" do
      assert PublicDomains.public?("gmail.com")
      refute PublicDomains.public?("codesandbox.io")
    end
  end
end
