module PortsHelper
  def parent_switch
    if self.is_switchport?
      self.switch
    elsif self.is_slotport?
      self.slot.switch
    end
  end

  def suspended?
    if self.suspended_at == nil && self.unsuspended_at == nil
      false
    elsif self.suspended_at && self.unsuspended_at == nil
      true
    elsif self.suspended_at == nil && self.unsuspended_at
      false
    elsif self.suspended_at > self.unsuspended_at
      true
    elsif self.suspended_at < self.unsuspended_at
      false
    end
  end
end
