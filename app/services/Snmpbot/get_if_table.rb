require 'snmp'
include SNMP

module Snmpbot
  NOHOST = "127.0.0.1"
  NOCOMMUNITY = "public"

  class GetIfTable < ApplicationService
    attr_accessor :host, :community

    def initialize(host=NOHOST, community=NOCOMMUNITY)
      @host = host
      @community = community
    end

    def call
      # GoatLogger.call("GetIfTable was run")
      get_if_table
    end

    def get_if_table
      results = Array.new
      begin
        SNMP::Manager.open(:host => @host, :community => @community) do |manager|
          manager.walk(["ifIndex", "ifName", "ifDescr", "ifOperStatus", "ifAdminStatus"]) do |ifIndex, ifName, ifDescr, ifOperStatus, ifAdminStatus|
            results << {
              :ifIndex => ifIndex.value.to_s,
              :ifName => ifName.value.to_s,
              :ifDescr => ifDescr.value.to_s,
              :ifOperStatus => ifOperStatus.value.to_s,
              :ifAdminStatus => ifAdminStatus.value.to_s
            }
          end
        end
      rescue => error
        GoatLogger.call("#{error.class}: #{error.message}")
      end
      return results
    end

  end
end
