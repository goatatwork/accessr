class Address < ApplicationRecord
  include AddressesHelper
  belongs_to :addressable, polymorphic: true
end
