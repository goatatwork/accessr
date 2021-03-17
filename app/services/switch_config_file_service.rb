require "pathname"

class SwitchConfigFileService < ApplicationService
  attr_accessor :switch_config, :path
  # attr_accessor :path

  def initialize(switch_config) # either SwitchConfig::class or string with path in it?
    @switch_config = switch_config
    @path = set_path
  end

  def set_path
    if @switch_config.instance_of?(SwitchConfig)
      active_storage_path = ActiveStorage::Blob.service.path_for(@switch_config.file.key) if @switch_config.file.attached?
      Pathname.new(active_storage_path)
    elsif @switch_config.is_a?(String)
      Pathname.new(@switch_config)
    end
  end

  def blocks
    self.split_by_exclamation
  end

  def blocks_html
    self.blocks.map do |block|
      block_text = block.strip
      replacement = "<br>".html_safe

      "#{block_text.gsub("\n",replacement)}" unless block_text == "\n"
    end
  end

  def contents_of_file_on_disk
    # @path.public_methods
    # file = @path.open
    # file_data = file.each_line do |line|
    #   line
    # end
    # file.close
    # file_data

    # # file_data = file.readlines.map(&:chomp)
    # file_data = file.each_line('!').map do |line|
    #   "#{line}"
    # end
    # file.close
    # file_data
  end

  # def contents_of_file_on_disk
  #   file = File.open(self.path_to_file_on_disk)
  #   file_data = file.readlines.map(&:chomp)
  #   file.close
  #   file_data
  # end

  # def blocks
  #   blocks_array = self.contents_of_file_on_disk.each_line('!')
  #   blocks_array
  # end

  # def path_to_file_on_disk
  #   if @switch_config.instance_of?(SwitchConfig)
  #     path = get_path_from_active_storage
  #   elsif @switch_config.is_a?(String)
  #     path = @switch_config
  #   end

  #   Pathname.new(path).to_s
  # end

  # private
  #   def get_path_from_active_storage
  #     if @switch_config.instance_of?(SwitchConfig)
  #       ActiveStorage::Blob.service.path_for(@switch_config.file.key) if @switch_config.file.attached?
  #     end
  #   end
  private
    def split_by_exclamation
      @path.read.split('!')
    end
end
