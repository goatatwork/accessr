# require 'net/ssh/telnet'

class UnsuspendPortService < ApplicationService

  include Accessr::TalksToHardware

  def initialize(port, switch, vlans)
    @port = port
    @switch = switch
    @vlans = vlans
  end

  def call
    unsuspend_port
  end

  def unsuspend_port
    s = @switch.start_ssh_session

    # output_rates = s.cmd({
    #   "String" => "show rate-limit output-shaping",
    # })

    # GoatLogger.call(output_rates)

    s.cmd({ "String" => "enable", "Match" => %r{User Name:} })
    s.cmd({ "String" => "#{@switch.ssh_user}", "Match" => %r{Password:} })
    s.cmd({ "String" => "#{@switch.ssh_password}", "Match" => %r{#{@switch.hostname}#} })
    s.cmd({ "String" => "skip-page-display", "Match" => %r{#{@switch.hostname}#} })

    running_config = s.cmd({ "String" => "show running-config", "Match" => %r{#{@switch.hostname}#} })
    config_processed = CrustyOldVendorConfig.new(running_config)

    port_to_unsuspend = "#{@port.name.delete_prefix('ethernet')}"
    input_rate = config_processed.input_rate_limit(port_to_unsuspend)
    output_rate = config_processed.output_rate_limit(port_to_unsuspend)

    s.cmd({ "String" => "config t", "Match" => %r{\(config\)#$} })

    s.cmd({ "String" => "interface #{@port.name}", "Match" => %r{#{@port.name.delete_prefix('ethernet')}\)#$} })

    s.cmd({ "String" => "no rate-limit input fixed #{input_rate}", "Match" => %r{#{@port.name.delete_prefix('ethernet')}\)#$} })
    s.cmd({ "String" => "no rate-limit output shaping #{output_rate}", "Match" => %r{#{@port.name.delete_prefix('ethernet')}\)#$} })

    s.cmd({ "String" => "exit", "Match" => %r{\(config\)#$} })

    vlans_array.each do |vlan|
      s.cmd({ "String" => "vlan #{vlan}", "Match" => %r{config-vlan-#{vlan}\)#$} })
      output = s.cmd({ "String" => "tagged #{@port.name}", "Match" => %r{config-vlan-#{vlan}\)#$} })
      s.cmd({ "String" => "exit", "Match" => %r{\(config\)#$} })
      GoatLogger.call(output)
    end

    s.cmd({ "String" => "interface #{@port.name}", "Match" => %r{#{@port.name.delete_prefix('ethernet')}\)#$} })
    s.cmd({ "String" => "rate-limit input fixed #{input_rate}", "Match" => %r{#{@port.name.delete_prefix('ethernet')}\)#$} })
    s.cmd({ "String" => "rate-limit output shaping #{output_rate}", "Match" => %r{#{@port.name.delete_prefix('ethernet')}\)#$} })
    s.cmd({ "String" => "exit", "Match" => %r{\(config\)#$} })

    s.cmd({ "String" => "exit", "Match" => %r{#{@switch.hostname}#} })
    write_mem_output = s.cmd({ "String" => "write mem", "Match" => %r{#{@switch.hostname}#} })
    s.cmd("exit")
    s.cmd("exit")
  end

  def vlans_array
    @vlans.split(",")
  end
end
