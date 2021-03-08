class Switch < ApplicationRecord
  has_many :slots
  has_many :ports, as: :portable
  has_many :slot_ports, through: :slots, source: :ports
  has_many_attached :config_backups

  def total_number_of_ports
    self.ports.count + self.slot_ports.count
  end
end
