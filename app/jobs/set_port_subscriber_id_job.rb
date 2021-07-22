class SetPortSubscriberIdJob < ApplicationJob
  queue_as :default

  def perform(port, subscriber_id)

    if port.portable_type == 'Switch'
      switch = port.switch
    elsif port.portable_type == 'Slot'
      switch = port.slot.switch
    end

    SetPortSubscriberIdService.call(port, switch, subscriber_id)

  end
end
