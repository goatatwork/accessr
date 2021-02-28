require "application_system_test_case"

class SubnetsTest < ApplicationSystemTestCase
  setup do
    @subnet = subnets(:one)
  end

  test "visiting the index" do
    visit subnets_url
    assert_selector "h1", text: "Subnets"
  end

  test "creating a Subnet" do
    visit subnets_url
    click_on "New Subnet"

    fill_in "Cidr", with: @subnet.cidr
    fill_in "Name", with: @subnet.name
    fill_in "Network address", with: @subnet.network_address
    fill_in "Shared network", with: @subnet.shared_network_id
    click_on "Create Subnet"

    assert_text "Subnet was successfully created"
    click_on "Back"
  end

  test "updating a Subnet" do
    visit subnets_url
    click_on "Edit", match: :first

    fill_in "Cidr", with: @subnet.cidr
    fill_in "Name", with: @subnet.name
    fill_in "Network address", with: @subnet.network_address
    fill_in "Shared network", with: @subnet.shared_network_id
    click_on "Update Subnet"

    assert_text "Subnet was successfully updated"
    click_on "Back"
  end

  test "destroying a Subnet" do
    visit subnets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Subnet was successfully destroyed"
  end
end
