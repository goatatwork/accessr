require "test_helper"

class DisablePortsApiControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get disable_ports_show_url
    assert_response :success
  end

  test "should get update" do
    get disable_ports_update_url
    assert_response :success
  end
end
