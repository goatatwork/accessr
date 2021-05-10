require 'snmp'

module Snmpbot
  NOHOST = "127.0.0.1"

  class GetSysDescr < ApplicationService
    attr_accessor :host

    def initialize(host=NOHOST)
      @host = host
    end

    def call
      # GoatLogger.call("GetSysDescr was run")
      get_sys_descr
    end

    def get_sys_descr
      SNMP::Manager.open(:host => @host) do |manager|
        response = manager.get(["sysDescr.0"])
        response.each_varbind do |vb|
          GoatLogger.call("#{vb.value.to_s}")
          return "#{vb.value.to_s}"
        end
      end

    end

  end
end
