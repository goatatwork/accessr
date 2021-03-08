class SwitchConfig < ApplicationRecord
  belongs_to :switch
  has_one_attached :file
end
