module ProvisioningRecordsHelper
  def display_customer
    self.location.customer.full_name if self.location.present?
  end

  def display_ip
    self.ip.address if self.ip.present?
  end

  def display_location
    self.location.name if self.location.present?
  end

  def display_ont
    "#{self.ont.manufacturer} #{self.ont.model}" if self.ont.present?
  end

  def port_name
    self.port.name if self.port.present?
  end

  def switch_name
    if self.port.present?
      if self.port.is_slotport?
        self.port.slot.switch.name
      end

      if self.port.is_switchport?
        self.port.switch.name
      end
    end
  end

  def select_ip_array
    Ip.all.map do |ip|
      [ip.address, ip.id]
    end
  end

  def select_location_array
    Location.all.map do |location|
      ["#{location.customer.full_name} / #{location.name}", location.id]
    end
  end

  def select_ont_array
    Ont.all.map do |ont|
      ["#{ont.manufacturer} #{ont.model}", ont.id]
    end
  end

  def select_port_array
    Port.all.map do |port|
      if port.is_switchport?
        ["Switch: #{port.switch.name} Port: #{port.name}", port.id]
      elsif port.is_slotport?
        ["Switch: #{port.slot.switch.name} Slot: #{port.slot.slot_number} Port: #{port.name}", port.id]
      end
    end
  end

  def select_switch_array
    Switch.all.map do |switch|
      ["#{switch.name}", switch.id]
    end
  end
end
