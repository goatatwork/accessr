require "application_system_test_case"

class SharedNetworksTest < ApplicationSystemTestCase
  setup do
    @shared_network = shared_networks(:one)
  end

  test "visiting the index" do
    visit shared_networks_url
    assert_selector "h1", text: "Shared Networks"
  end

  test "creating a Shared network" do
    visit shared_networks_url
    click_on "New Shared Network"

    fill_in "Dhcp server", with: @shared_network.dhcp_server_id
    fill_in "Name", with: @shared_network.name
    fill_in "Relayed from ip", with: @shared_network.relayed_from_ip
    click_on "Create Shared network"

    assert_text "Shared network was successfully created"
    click_on "Back"
  end

  test "updating a Shared network" do
    visit shared_networks_url
    click_on "Edit", match: :first

    fill_in "Dhcp server", with: @shared_network.dhcp_server_id
    fill_in "Name", with: @shared_network.name
    fill_in "Relayed from ip", with: @shared_network.relayed_from_ip
    click_on "Update Shared network"

    assert_text "Shared network was successfully updated"
    click_on "Back"
  end

  test "destroying a Shared network" do
    visit shared_networks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Shared network was successfully destroyed"
  end
end
