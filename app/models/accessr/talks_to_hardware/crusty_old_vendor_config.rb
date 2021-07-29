require 'net/ssh/telnet'

module Accessr
  module TalksToHardware

    class CrustyOldVendorConfig

      attr_accessor :original_input, :facts

      def initialize(original_input)
        @original_input = original_input
        @facts = {
          :input_rate_limit => '',
          :output_rate_limit => ''
        }
      end

      def as_array(delimiter="!")
        working_block = @original_input.split(delimiter).reject! do |config_block|
          config_block == "\n"
        end

        working_block.map! do |config_block|
          config_block.delete_prefix("\n")
        end

        working_block.map! do |config_block|
          config_block.split("\n").map! do |line|
            line.strip
          end
        end

        working_block
      end

      def interface(interface)
        blocks_that_start_with_this_interface = self.as_array.select do |block_array|
          block_array[0] == "interface ethernet #{interface}"
        end

        blocks_that_start_with_this_interface[0]
      end

      def input_rate_limit(interface)
        block_in_question = self.interface(interface)

        current_setting = block_in_question.select do |element|
          element.match("rate-limit input fixed")
        end

        the_value = current_setting.first.delete_prefix("rate-limit input fixed ") if current_setting.first

        @facts[:input_rate_limit] = the_value

        return the_value
      end

      def output_rate_limit(interface)
        block_in_question = self.interface(interface)

        current_setting = block_in_question.select do |element|
          element.match("rate-limit output shaping")
        end

        the_value = current_setting.first.delete_prefix("rate-limit output shaping ") if current_setting.first

        @facts[:output_rate_limit] = the_value

        return the_value
      end
    end
  end
end
