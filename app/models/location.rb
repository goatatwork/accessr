class Location < ApplicationRecord
  belongs_to :customer
  has_one :address, as: :addressable
end
