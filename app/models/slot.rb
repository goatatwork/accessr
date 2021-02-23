class Slot < ApplicationRecord
  belongs_to :switch
  has_many :ports, as: :portable
end
