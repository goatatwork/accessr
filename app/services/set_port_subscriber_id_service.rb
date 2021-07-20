require 'net/ssh/telnet'

class SetPortSubscriberIdService < ApplicationService

  def initialize(port, switch, subscriber_id)
    @port = port
    @switch = switch
    @subscriber_id = subscriber_id
  end

  def call
    set_subscriber_id
  end

  def not_set_subscriber_id
    GoatLogger.call("port #{@port.name}, switch #{@switch.management_ip}, subscriber_id #{@subscriber_id}")
  end

  def set_subscriber_id
    GoatLogger.call("Start setting #{@port.name} subscriber-id to #{@subscriber_id} on switch at #{@switch.management_ip}")

    s = @switch.start_ssh_session

    s.cmd({ "String" => "enable", "Match" => %r{User Name:} })
    s.cmd({ "String" => "#{@switch.ssh_user}", "Match" => %r{Password:} })
    s.cmd({ "String" => "#{@switch.ssh_password}", "Match" => %r{#{@switch.hostname}#} })
    s.cmd({ "String" => "config t", "Match" => %r{\(config\)#$} })
    s.cmd({ "String" => "interface #{@port.name}", "Match" => %r{#{@port.name.delete_prefix('ethernet')}\)#$} }) # delete_prefix makes 1/1/1 out of config-if-e1000-1/1/1

    in_output = s.cmd({ "String" => "dhcp snooping relay information subscriber-id #{@subscriber_id}", "Match" => %r{#{@port.name.delete_prefix('ethernet')}\)#$} })

    s.cmd({ "String" => "exit", "Match" => %r{\(config\)#$} })
    s.cmd({ "String" => "exit", "Match" => %r{#{@switch.hostname}#} })
    write_mem_output = s.cmd({ "String" => "write mem", "Match" => %r{#{@switch.hostname}#} })
    s.cmd("exit")
    s.cmd("exit")

    GoatLogger.call("Finished setting #{@port.name} subscriber-id to #{@subscriber_id} on switch at #{@switch.management_ip}")
  end
end
