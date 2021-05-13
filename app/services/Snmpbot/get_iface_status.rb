require 'snmp'

module Snmpbot
  class GetIfaceStatus < ApplicationService

    def call
      GoatLogger.call("GetIfaceStatus was run")
    end

  end
end
