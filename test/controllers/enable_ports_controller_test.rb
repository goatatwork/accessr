require "test_helper"

class EnablePortsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get enable_ports_show_url
    assert_response :success
  end

  test "should get update" do
    get enable_ports_update_url
    assert_response :success
  end
end
