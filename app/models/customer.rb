class Customer < ApplicationRecord
  include CustomersHelper
  has_many :locations
  has_many :provisioning_records, through: :locations
  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true
  validates :first_name, presence: true

  def provisioned?
    self.provisioning_records.any?
  end
end
