require "test_helper"

class IpTest < ActiveSupport::TestCase
  test "should know if it has provisioning records" do
    assert ips(:one).provisioned?
  end

  test "should know if it does not have provisioning records" do
    assert_not ips(:three).provisioned?
  end
end
