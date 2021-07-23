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
    assert_not ports(:three).provisioned?
  end

  test "should know if it is a slot port" do
    assert ports(:slot_port_1).is_slotport?
  end

  test "should know if it is not a slot port" do
    assert_not ports(:three).is_slotport?
  end
end
