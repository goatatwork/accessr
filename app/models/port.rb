class Port < ApplicationRecord
  belongs_to :portable, polymorphic: true
end
