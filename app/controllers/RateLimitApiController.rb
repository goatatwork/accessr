class RateLimitApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update
    message = "updating a rate limit";

    if params[:switch_ip] && @switch = Switch.where(management_ip: params[:switch_ip]).first
      if params[:port_name] && @port = @switch.ports.where(name: params[:port_name]).first
        down_rate = params[:down_rate]
        up_rate = params[:up_rate]

        if @port.update(down_rate: down_rate, up_rate: up_rate)
          SetPortRateLimitJob.perform_later(@port)
          message = "On #{@switch.name}, setting #{@port.name} to #{down_rate} down and #{up_rate} up."
        end

      end
    end

    GoatLogger.call(message)

    render json: {success: message}
  end

  def show
    render json: {success: true}
  end

  private

    # Only allow a list of trusted parameters through.
    def port_params
      params.require(:port).permit(:port_number, :name, :description, :up_rate, :down_rate, :rate_unit)
    end
end
