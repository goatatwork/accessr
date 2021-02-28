class Subnet < ApplicationRecord
  belongs_to :shared_network
  has_many :pools
end
