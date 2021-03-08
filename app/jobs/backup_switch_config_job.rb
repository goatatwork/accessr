require 'net/ssh/telnet'

class BackupSwitchConfigJob < ApplicationJob
  queue_as :default

  def perform(switch, switch_config)

    BackupSwitchConfigService.call(switch, switch_config)

  end
end
