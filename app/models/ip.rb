class Ip < ApplicationRecord
  belongs_to :pool
  has_many :provisioning_records

  has_many :locations, through: :provisioning_records
  has_many :onts, through: :provisioning_records
  has_many :ports, through: :provisioning_records

  def provisioned?
    self.provisioning_records.any?
  end
end
