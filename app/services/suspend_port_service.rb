# require 'net/ssh/telnet'

class SuspendPortService < ApplicationService

  def initialize(port, switch, vlans)
    @port = port
    @switch = switch
    @vlans = vlans
  end

  def call
    suspend_port
  end

  def suspend_port
    s = @switch.start_ssh_session

    s.cmd({ "String" => "enable", "Match" => %r{User Name:} })
    s.cmd({ "String" => "#{@switch.ssh_user}", "Match" => %r{Password:} })
    s.cmd({ "String" => "#{@switch.ssh_password}", "Match" => %r{#{@switch.hostname}#} })
    s.cmd({ "String" => "config t", "Match" => %r{\(config\)#$} })

    vlans_array.each do |vlan|
      s.cmd({ "String" => "vlan #{vlan}", "Match" => %r{config-vlan-#{vlan}\)#$} })
      output = s.cmd({ "String" => "no tagged #{@port.name}", "Match" => %r{config-vlan-#{vlan}\)#$} })
      s.cmd({ "String" => "exit", "Match" => %r{\(config\)#$} })
      GoatLogger.call(output)
    end

    s.cmd({ "String" => "exit", "Match" => %r{#{@switch.hostname}#} })
    write_mem_output = s.cmd({ "String" => "write mem", "Match" => %r{#{@switch.hostname}#} })
    s.cmd("exit")
    s.cmd("exit")

    @port.update_attribute(:switch_informed, DateTime.now)
  end

  def vlans_array
    @vlans.split(",")
  end
end
