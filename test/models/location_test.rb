require "test_helper"

class LocationTest < ActiveSupport::TestCase
  test "should know if it has provisioning records" do
    assert locations(:one).provisioned?
  end

  test "should know if it does not have provisioning records" do
    assert_not locations(:three).provisioned?
  end
end
