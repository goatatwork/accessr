class RateLimitApiController < ApplicationController
  def update
    switch_ip = params[:switch_ip]
    port_name = params[:port_name]
    down_rate = param[:down_rate]
    up_rate = params[:up_rate]

    message = "On the switch at #{switch_ip}, change port #{port_name} to have #{down_rate} down and #{up_rate} up."

    GoatLogger.call(message)
    "success"
  end
end
