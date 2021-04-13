class RateLimitApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update
    switch_ip = params[:switch_ip]
    port_name = params[:port_name]
    down_rate = params[:down_rate]
    up_rate = params[:up_rate]

    message = "On the switch at #{switch_ip}, change port #{port_name} to have #{down_rate} down and #{up_rate} up."

    GoatLogger.call(message)

    render json: {success: message}
  end

  def show
    render json: {success: true}
  end
end
