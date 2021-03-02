module AddressesHelper
  def display_address_type
    if self.addressable_type == 'Customer'
      'Billing Address'
    end
    if self.addressable_type == 'Location'
      'Service Address'
    end
  end
end
