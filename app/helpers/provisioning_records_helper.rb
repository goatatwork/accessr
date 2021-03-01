module ProvisioningRecordsHelper
  def display_customer
    "#{self.location.customer.full_name}"
  end

  def display_ip
    "#{self.ip.address}"
  end

  def display_location
    "#{self.location.name}"
  end

  def display_ont
    "#{self.ont.name}"
  end

  def display_port
    if self.port.is_slotport?
      "Slot: #{self.port.slot.slot_number} Port: #{self.port.port_number} Switch: #{self.port.slot.switch.name}"
    end

    if self.port.is_switchport?
      "Port: #{self.port.port_number} Switch: #{self.port.switch.name}"
    end
  end

end
