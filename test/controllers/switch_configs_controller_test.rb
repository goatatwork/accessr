require "test_helper"

class SwitchConfigsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @switch_config = switch_configs(:one)
  end

  test "should get index" do
    get switch_configs_url
    assert_response :success
  end

  test "should get new" do
    get new_switch_config_url
    assert_response :success
  end

  test "should create switch_config" do
    assert_difference('SwitchConfig.count') do
      post switch_configs_url, params: { switch_config: { active: @switch_config.active, name: @switch_config.name, switch_id: @switch_config.switch_id } }
    end

    assert_redirected_to switch_config_url(SwitchConfig.last)
  end

  test "should show switch_config" do
    get switch_config_url(@switch_config)
    assert_response :success
  end

  test "should get edit" do
    get edit_switch_config_url(@switch_config)
    assert_response :success
  end

  test "should update switch_config" do
    patch switch_config_url(@switch_config), params: { switch_config: { active: @switch_config.active, name: @switch_config.name, switch_id: @switch_config.switch_id } }
    assert_redirected_to switch_config_url(@switch_config)
  end

  test "should destroy switch_config" do
    assert_difference('SwitchConfig.count', -1) do
      delete switch_config_url(@switch_config)
    end

    assert_redirected_to switch_configs_url
  end
end
