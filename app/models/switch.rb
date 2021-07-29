class Switch < ApplicationRecord
  include SwitchesHelper
  include Accessr::TalksToHardware

  after_create_commit -> { broadcast_prepend_to "switches" }
  after_update_commit -> { broadcast_replace_to "switches" }
  after_destroy_commit -> { broadcast_remove_to "switches" }

  DEFAULT_UP_RATE = 3000
  DEFAULT_DOWN_RATE = 25000

  has_many :slots, dependent: :destroy
  has_many :ports, as: :portable, dependent: :destroy
  has_many :slot_ports, through: :slots, source: :ports
  has_many :switch_configs

  def start_ssh_session
    new_ssh = SshConnector.new(self)
    new_ssh.start_session
  end

  def total_number_of_ports
    self.ports.count + self.slot_ports.count
  end

end
