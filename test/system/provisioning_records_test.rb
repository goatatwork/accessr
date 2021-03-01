require "application_system_test_case"

class ProvisioningRecordsTest < ApplicationSystemTestCase
  setup do
    @provisioning_record = provisioning_records(:one)
  end

  test "visiting the index" do
    visit provisioning_records_url
    assert_selector "h1", text: "Provisioning Records"
  end

  test "creating a Provisioning record" do
    visit provisioning_records_url
    click_on "New Provisioning Record"

    fill_in "Ip", with: @provisioning_record.ip_id
    fill_in "Location", with: @provisioning_record.location_id
    fill_in "Ont", with: @provisioning_record.ont_id
    fill_in "Port", with: @provisioning_record.port_id
    click_on "Create Provisioning record"

    assert_text "Provisioning record was successfully created"
    click_on "Back"
  end

  test "updating a Provisioning record" do
    visit provisioning_records_url
    click_on "Edit", match: :first

    fill_in "Ip", with: @provisioning_record.ip_id
    fill_in "Location", with: @provisioning_record.location_id
    fill_in "Ont", with: @provisioning_record.ont_id
    fill_in "Port", with: @provisioning_record.port_id
    click_on "Update Provisioning record"

    assert_text "Provisioning record was successfully updated"
    click_on "Back"
  end

  test "destroying a Provisioning record" do
    visit provisioning_records_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Provisioning record was successfully destroyed"
  end
end
