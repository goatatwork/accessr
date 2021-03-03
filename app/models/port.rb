class Port < ApplicationRecord
  belongs_to :portable, polymorphic: true
  has_many :provisioning_records

  has_many :ips, through: :provisioning_records
  has_many :locations, through: :provisioning_records
  has_many :onts, through: :provisioning_records


  def is_slotport?
    self.portable_type == 'Slot'
  end

  def is_switchport?
    self.portable_type == 'Switch'
  end

  def slot
    self.portable if self.portable_type == 'Slot'
  end

  def switch
    self.portable if self.portable_type == 'Switch'
  end

end
