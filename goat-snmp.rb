require 'snmp'

ifTable_columns = ["ifName", "ifDescr"]
SNMP::Manager.open(:host => '192.168.99.1') do |manager|
    manager.walk(ifTable_columns) do |row|
        row.each { |vb| print "\t#{vb.value}" }
        puts
    end
end
