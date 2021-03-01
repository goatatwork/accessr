class SharedNetwork < ApplicationRecord
  belongs_to :dhcp_server
  has_many :subnets
end
