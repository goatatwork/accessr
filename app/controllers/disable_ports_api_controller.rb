class DisablePortsApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
  end

  def update
    if params[:switch_ip] && @switch = Switch.where(management_ip: params[:switch_ip]).first
      if params[:port_name] && @port = @switch.ports.where(name: params[:port_name]).first

        disabled_at = DateTime.now.in_time_zone

        if @port.update(disabled_at: disabled_at)
          EnablePortJob.perform_later(@port)
          message = "Port #{@port.name} on switch #{@switch.name} disabled."
        end
      end
    end

    GoatLogger.call(message)
    render json: {success: message}
  end

  private

    def port_params
      params.require(:port).permit(:port_number)
    end
end
