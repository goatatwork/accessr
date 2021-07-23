require "test_helper"
require "time"

class PortTest < ActiveSupport::TestCase
  test "the port fixture can create dates" do
    port = Port.first

    assert_equal port.enabled_at, Time.parse("2003-07-16t15:28:11.2233+01:00")
  end

  test "should know if it has provisioning records" do
    assert ports(:one).provisioned?
  end

  test "should know if it does not have provisioning records" do
    assert_not ips(:three).provisioned?
  end

end
