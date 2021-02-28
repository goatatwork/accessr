require "application_system_test_case"

class DhcpServersTest < ApplicationSystemTestCase
  setup do
    @dhcp_server = dhcp_servers(:one)
  end

  test "visiting the index" do
    visit dhcp_servers_url
    assert_selector "h1", text: "Dhcp Servers"
  end

  test "creating a Dhcp server" do
    visit dhcp_servers_url
    click_on "New Dhcp Server"

    fill_in "Name", with: @dhcp_server.name
    fill_in "Server type", with: @dhcp_server.server_type
    click_on "Create Dhcp server"

    assert_text "Dhcp server was successfully created"
    click_on "Back"
  end

  test "updating a Dhcp server" do
    visit dhcp_servers_url
    click_on "Edit", match: :first

    fill_in "Name", with: @dhcp_server.name
    fill_in "Server type", with: @dhcp_server.server_type
    click_on "Update Dhcp server"

    assert_text "Dhcp server was successfully updated"
    click_on "Back"
  end

  test "destroying a Dhcp server" do
    visit dhcp_servers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Dhcp server was successfully destroyed"
  end
end
