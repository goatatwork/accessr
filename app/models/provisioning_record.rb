class ProvisioningRecord < ApplicationRecord
  include ProvisioningRecordsHelper

  belongs_to :location
  belongs_to :port
  belongs_to :ip
  belongs_to :ont
end
