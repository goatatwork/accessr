class Pool < ApplicationRecord
  belongs_to :subnet
  has_many :ips
end
