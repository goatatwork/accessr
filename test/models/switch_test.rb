require "test_helper"

class SwitchTest < ActiveSupport::TestCase
  test "switch should be able to report total ports onboard and on slots" do
    assert_equal 2, switches(:basement_stack_1).total_number_of_ports
  end
end
