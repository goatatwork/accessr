class Customer < ApplicationRecord
  has_many :locations
  has_one :addresses, as: :addressable
end
