require 'net/ssh/telnet'

class BackupSwitchConfigService < ApplicationService

  def initialize(switch, switch_config)
    @switch = switch
    @switch_config = switch_config
  end

  def call
    backup_config
  end

  def backup_config
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
    running_config = s.cmd({ "String" => "show running-config", "Match" => %r{#{@switch.hostname}#} })

    s.cmd("exit")
    s.cmd("exit")

    File.write("tmp/switchconfig-#{@switch_config.id}-switch-#{@switch.id}-running-config", running_config, mode: "a")

    associate_file_with_switch("tmp/switchconfig-#{@switch_config.id}-switch-#{@switch.id}-running-config")
  end

  def associate_file_with_switch(path_to_file)
    @switch_config.file.attach(io: File.open(path_to_file), filename: "switchconfig-#{@switch_config.id}-switch-#{@switch.id}-running-config")
    File.delete(path_to_file)
    GoatLogger.call("Attached switchconfig-#{@switch_config.id}-switch-#{@switch.id}-running-config to #{@switch.name} and deleted it.")
  end
end
