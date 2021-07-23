require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  test "should not save without a first name" do
    customer = Customer.new
    assert_not customer.save, "\nBad robot saved a customer without a first name."
  end

  test "should report error" do
    assert_raises(NameError) do
      some_undefine_variable
    end
  end

  test "should know if it has provisioning records" do
    assert customers(:one).provisioned?
  end

  test "should know if it does not have provisioning records" do
    assert_not customers(:three).provisioned?
  end
end
