require 'net/ssh/telnet'

class DisablePortService < ApplicationService

  include Accessr::TalksToHardware

  def initialize(port, switch)
    @port = port
    @switch = switch
  end

  def call
    disable_port
  end

  def disable_port
    GoatLogger.call("Disabling #{@port.name}:#{@port.id} on #{@switch.management_ip}:#{@switch.id}")

    s = @switch.start_ssh_session

    s.cmd({ "String" => "enable", "Match" => %r{User Name:} })
    s.cmd({ "String" => "#{@switch.ssh_user}", "Match" => %r{Password:} })
    s.cmd({ "String" => "#{@switch.ssh_password}", "Match" => %r{#{@switch.hostname}#} })
    s.cmd({ "String" => "config t", "Match" => %r{\(config\)#$} })
    s.cmd({ "String" => "interface #{@port.name}", "Match" => %r{#{@port.name.delete_prefix('ethernet')}\)#$} }) # delete_prefix makes 1/1/1 out of config-if-e1000-1/1/1
    # not having to escape "/" here is a feture of ruby's r%{}
    s.cmd({ "String" => "disable", "Match" => %r{#{@port.name.delete_prefix('ethernet')}\)#$} })
    s.cmd({ "String" => "exit", "Match" => %r{\(config\)#$} })
    s.cmd({ "String" => "exit", "Match" => %r{#{@switch.hostname}#} })
    write_mem_output = s.cmd({ "String" => "write mem", "Match" => %r{#{@switch.hostname}#} })
    s.cmd("exit")
    s.cmd("exit")

    GoatLogger.call("#{@port.name} has been disabled.")
  end
end
