class RateLimitApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update
    message = "updating a rate limit";

    if params[:switch_ip] && @switch = Switch.where(management_ip: params[:switch_ip]).first
      if params[:port_name] && @port = @switch.ports.where(name: params[:port_name]).first
        down_rate = params[:down_rate]
        up_rate = params[:up_rate]
        message = "On the switch at #{@switch.name}, change #{@port.name} to have #{down_rate} down and #{up_rate} up."
      end
    end

    GoatLogger.call(message)

    render json: {success: message}
  end

  def show
    render json: {success: true}
  end
end
