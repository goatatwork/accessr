class SwitchConfig < ApplicationRecord

  include SwitchConfigsHelper

  belongs_to :switch
  has_one_attached :file
end
