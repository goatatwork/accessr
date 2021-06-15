require 'snmp'

module Snmpbot
  NOHOST = "127.0.0.1"
  NOCOMMUNITY="public"

  class GetSysDescr < ApplicationService
    attr_accessor :host, :community

    def initialize(host=NOHOST,community=NOCOMMUNITY)
      @host = host
      @community = community
    end

    def call
      get_sys_descr
    end

    def get_sys_descr
      begin
        SNMP::Manager.open(:host => @host, :community => @community) do |manager|
          response = manager.get(["sysDescr.0"])
          response.each_varbind do |vb|
            # GoatLogger.call("#{vb.value.to_s}")
            return "#{vb.value.to_s}"
          end
        end
      rescue => error
        GoatLogger.call("#{error.class}: #{error.message}")
      end

    end

  end
end
