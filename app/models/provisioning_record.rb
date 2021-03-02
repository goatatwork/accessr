class ProvisioningRecord < ApplicationRecord
  include ProvisioningRecordsHelper

  belongs_to :location, optional: true
  belongs_to :port, optional: true
  belongs_to :ip, optional: true
  belongs_to :ont, optional: true
end
