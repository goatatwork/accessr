require 'net/ssh/telnet'

class GetVlansService < ApplicationService

  def initialize(switch, switch_config)
    @switch = switch
    @switch_config = switch_config
  end

  def call
    get_vlans
  end

  def get_vlans
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
    s.cmd({ "String" => "skip-page-display", "Match" => %r{#{@switch.hostname}#} })

    switch_vlans = s.cmd({ "String" => "show vlan br", "Match" => %r{#{@switch.hostname}#} })

    s.cmd("exit")

    display_vlans(switch_vlans)
  end

  def display_vlans(output)
    get_configured_vlans_line(output)
  end

  def get_configured_vlans_line(output)
    output.each_line do |line|
      return line.chomp.split(":").last.split(" ") if line.start_with?("VLANs Configured")
    end
  end

end
