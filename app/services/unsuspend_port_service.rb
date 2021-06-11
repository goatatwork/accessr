require 'net/ssh/telnet'

class UnsuspendPortService < ApplicationService

  def initialize(port, switch, vlans)
    @port = port
    @switch = switch
    @vlans = vlans
  end

  def call
    unsuspend_port
  end

  def unsuspend_port
    ssh = Net::SSH.start(@switch.management_ip, @switch.ssh_user,
      password: @switch.ssh_password,
      config: true,
      host_key: '+ssh-dss',
      kex: '+diffie-hellman-group1-sha1'
    )

    s = Net::SSH::Telnet.new("Dump_log" => "/dev/null", "Session" => ssh, "Prompt" => %r{#{@switch.hostname}>})

    s.cmd({ "String" => "enable", "Match" => %r{User Name:} })
    s.cmd({ "String" => "#{@switch.ssh_user}", "Match" => %r{Password:} })
    s.cmd({ "String" => "#{@switch.ssh_password}", "Match" => %r{#{@switch.hostname}#} })
    s.cmd({ "String" => "config t", "Match" => %r{\(config\)#$} })

    vlans_array.each do |vlan|
      s.cmd({ "String" => "vlan #{vlan}", "Match" => %r{config-vlan-#{vlan}\)#$} })
      output = s.cmd({ "String" => "tagged #{@port.name}", "Match" => %r{config-vlan-#{vlan}\)#$} })
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
