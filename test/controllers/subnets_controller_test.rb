require "test_helper"

class SubnetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subnet = subnets(:one)
  end

  test "should get index" do
    get subnets_url
    assert_response :success
  end

  test "should get new" do
    get new_subnet_url
    assert_response :success
  end

  test "should create subnet" do
    assert_difference('Subnet.count') do
      post subnets_url, params: { subnet: { cidr: @subnet.cidr, name: @subnet.name, network_address: @subnet.network_address, shared_network_id: @subnet.shared_network_id } }
    end

    assert_redirected_to subnet_url(Subnet.last)
  end

  test "should show subnet" do
    get subnet_url(@subnet)
    assert_response :success
  end

  test "should get edit" do
    get edit_subnet_url(@subnet)
    assert_response :success
  end

  test "should update subnet" do
    patch subnet_url(@subnet), params: { subnet: { cidr: @subnet.cidr, name: @subnet.name, network_address: @subnet.network_address, shared_network_id: @subnet.shared_network_id } }
    assert_redirected_to subnet_url(@subnet)
  end

  test "should destroy subnet" do
    assert_difference('Subnet.count', -1) do
      delete subnet_url(@subnet)
    end

    assert_redirected_to subnets_url
  end
end
