require 'snmp'
include SNMP

module Snmpbot
  NOHOST = "127.0.0.1"

  class GetIfTable < ApplicationService
    attr_accessor :host

    def initialize(host=NOHOST)
      @host = host
    end

    def call
      # GoatLogger.call("GetIfTable was run")
      get_if_table
    end

    def get_if_table
      results = Array.new
      begin
        SNMP::Manager.open(:Host => "192.168.99.1") do |manager|
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
      # manager = Manager.new(:Host => @host, :Port => 161)
      # ifTable = ObjectId.new("1.3.6.1.2.1.2.2")
      # next_oid = ifTable
      # results = Array.new
      # while next_oid.subtree_of?(ifTable)
      #   response = manager.get_next(next_oid)
      #   varbind = response.varbind_list.first
      #   next_oid = varbind.name
      #   log_message = "#{varbind.name.to_s}  #{varbind.value.to_s}"
      #   # GoatLogger.call(log_message)
      #   results << log_message
      # end
      # return results
    end

  end
end
