class Customer < ApplicationRecord
  include CustomersHelper

  has_many :locations
  has_one :address, as: :addressable
end
