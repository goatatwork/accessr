require 'snmp'

module SwitchesHelper
  def add_ports_from_snmp
    get_interfaces_from_snmp.each do |interface|
      self.ports.create(name:interface, up_rate: Switch::DEFAULT_UP_RATE, down_rate: Switch::DEFAULT_DOWN_RATE, description: 'added via snmp')
    end
  end

  def get_interfaces_from_snmp
    ifTable_columns = ["ifName"]
    interfaces = []
    SNMP::Manager.open(:host => self.management_ip) do |manager|
      manager.walk(ifTable_columns) do |row|
        row.each do |vb|
          interfaces.append(vb.value) if vb.value.starts_with?('ethernet')
        end
      end
    end
    interfaces
  end
end
