require 'snmp'

module Snmpbot
  NOHOST = "127.0.0.1"

  class Bot < ApplicationService
    attr_accessor :host

    def call
      get_interfaces_from_snmp
      puts "Snmp::Bot at your service."
    end

    def initialize(host=NOHOST)
      @host = host
    end

    def get_interfaces_from_snmp
      ifTable_columns = ["ifName","ifDescr"]
      interfaces = []
      SNMP::Manager.open(:host => @host) do |manager|
        manager.walk(ifTable_columns) do |row|

          ifName = row.first
          ifDescr = row.last
          interfaces << ifName.value.to_s

          # row.each do |vb|
          #   interfaces << vb.value if vb.value.starts_with?('ethernet')
          # end

        end
      end
      interfaces
    end

  end

end
