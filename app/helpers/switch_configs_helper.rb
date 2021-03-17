module SwitchConfigsHelper
  def config_blocks
    SwitchConfigFileService.new(self).blocks_html

  end
  def contents_of_file_on_disk
    SwitchConfigFileService.new(self).contents_of_file_on_disk
  end
end
