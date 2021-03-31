class Switch < ApplicationRecord
  include SwitchesHelper

  after_create_commit -> { broadcast_prepend_to "switches" }
  after_update_commit -> { broadcast_replace_to "switches" }
  after_destroy_commit -> { broadcast_remove_to "switches" }

  DEFAULT_UP_RATE = 3000
  DEFAULT_DOWN_RATE = 25000

  has_many :slots
  has_many :ports, as: :portable
  has_many :slot_ports, through: :slots, source: :ports
  has_many :switch_configs

  def total_number_of_ports
    self.ports.count + self.slot_ports.count
  end
end
