class Location < ApplicationRecord
  belongs_to :customer
  has_one :address, as: :addressable, dependent: :destroy
  has_many :provisioning_records

  has_many :ips, through: :provisioning_records
  has_many :onts, through: :provisioning_records
  has_many :ports, through: :provisioning_records

  accepts_nested_attributes_for :address, allow_destroy: true

  def provisioned?
    self.provisioning_records.any?
  end
end
