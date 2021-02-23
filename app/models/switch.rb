class Switch < ApplicationRecord
  has_many :slots

  has_many :ports, as: :portable
end
