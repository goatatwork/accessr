require 'net/ssh/telnet'

module Accessr
  module TalksToHardware

    class SshConnector

      def initialize(switch)
        @switch = switch
      end

      def start_session
        Net::SSH::Telnet.new("Dump_log" => "/dev/null", "Session" => new_ssh_object, "Prompt" => %r{#{@switch.hostname}>})
      end

      def new_ssh_object
        Net::SSH.start(@switch.management_ip, @switch.ssh_user,
          password: @switch.ssh_password,
          config: true,
          host_key: '+ssh-dss',
          kex: '+diffie-hellman-group1-sha1'
        )
      end

    end

  end
end
