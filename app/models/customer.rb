class Customer < ApplicationRecord
  include CustomersHelper
  has_many :locations
  has_one :address, as: :addressable
  accepts_nested_attributes_for :address, allow_destroy: true
end
