class UnsuspendPortJob < ApplicationJob
  queue_as :default

  def perform(port, vlans)

    if port.portable_type == 'Switch'
      switch = port.switch
    elsif port.portable_type == 'Slot'
      switch = port.slot.switch
    end

    UnsuspendPortService.call(port, switch, vlans)

  end
end
