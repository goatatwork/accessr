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

  test "there should be two fixture customers" do
    assert_equal 2, Customer.count
  end
end
