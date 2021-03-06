require 'net/ssh/telnet'

class SetPortRateLimitJob < ApplicationJob
  queue_as :default

  def perform(port)

    if port.portable_type == 'Switch'
      switch = port.switch
    elsif port.portable_type == 'Slot'
      switch = port.slot.switch
    end

    SetPortRateLimitService.call(port, switch)

  end
end
