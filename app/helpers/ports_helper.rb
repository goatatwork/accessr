module PortsHelper
  def parent_switch
    if self.is_switchport?
      self.switch
    elsif self.is_slotport?
      self.slot.switch
    end
  end
end
