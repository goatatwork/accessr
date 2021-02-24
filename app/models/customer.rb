class Customer < ApplicationRecord
  include CustomersHelper

  has_many :locations
  has_one :addresses, as: :addressable
end
