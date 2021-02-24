require "application_system_test_case"

class PortsTest < ApplicationSystemTestCase
  setup do
    @port = ports(:one)
  end

  test "visiting the index" do
    visit ports_url
    assert_selector "h1", text: "Ports"
  end

  test "creating a Port" do
    visit ports_url
    click_on "New Port"

    fill_in "Description", with: @port.description
    fill_in "Name", with: @port.name
    fill_in "Port number", with: @port.port_number
    fill_in "Portable", with: @port.portable_id
    fill_in "Portable type", with: @port.portable_type
    click_on "Create Port"

    assert_text "Port was successfully created"
    click_on "Back"
  end

  test "updating a Port" do
    visit ports_url
    click_on "Edit", match: :first

    fill_in "Description", with: @port.description
    fill_in "Name", with: @port.name
    fill_in "Port number", with: @port.port_number
    fill_in "Portable", with: @port.portable_id
    fill_in "Portable type", with: @port.portable_type
    click_on "Update Port"

    assert_text "Port was successfully updated"
    click_on "Back"
  end

  test "destroying a Port" do
    visit ports_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Port was successfully destroyed"
  end
end
