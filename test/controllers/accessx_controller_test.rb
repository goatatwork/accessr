require "test_helper"

class AccessxControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get accessx_index_url
    assert_response :success
  end

  test "should get customers" do
    get accessx_customers_url
    assert_response :success
  end
end
