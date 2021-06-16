require 'snmp'

module SwitchesHelper
  def add_ports_from_snmp
    get_interfaces_from_snmp.each do |interface|
      self.ports.create(name: interface[:ifName], up_rate: Switch::DEFAULT_UP_RATE, down_rate: Switch::DEFAULT_DOWN_RATE, description: interface[:ifDescr])
    end
  end

    def get_interfaces_from_snmp
      ifTable_columns = ["ifName","ifDescr"]
      interfaces = []
      SNMP::Manager.open(:host => self.management_ip, :community => self.snmp_community) do |manager|
        manager.walk(ifTable_columns) do |row|
          ifName = row.first
          ifDescr = row.last
          interfaces << { ifName: ifName.value.to_s, ifDescr: ifDescr.value.to_s }
        end
      end
      interfaces
    end

  def snmp_get_if_table(switch)
    Snmpbot::GetIfTable.call(switch.management_ip, switch.snmp_community)
  end

  def snmp_get_sys_descr(switch)
    Snmpbot::GetSysDescr.call(switch.management_ip, switch.snmp_community)
  end

end
