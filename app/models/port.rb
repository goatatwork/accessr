class Port < ApplicationRecord
  belongs_to :portable, polymorphic: true

  def slot
    self.portable if self.portable_type == 'Slot'
  end

  def switch
    self.portable if self.portable_type == 'Switch'
  end
end
