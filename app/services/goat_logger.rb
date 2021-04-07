class GoatLogger < ApplicationService
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def call
    File.write("goatlog.txt", "#{DateTime.current}: #{@message}\n", mode: "a")

    ActionCable.server.broadcast("goat_logger_channel", {
      name: @message
    })
  end
end
