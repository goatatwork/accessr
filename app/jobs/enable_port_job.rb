class EnablePortJob < ApplicationJob
  queue_as :default

  def perform(port)

    if port.portable_type == 'Switch'
      switch = port.switch
    elsif port.portable_type == 'Slot'
      switch = port.slot.switch
    end

    EnablePortService.call(port, switch)

  end
end
