class DisablePortsApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
  end

  def update
    if params[:switch_ip] && @switch = Switch.where(management_ip: params[:switch_ip]).first
      if params[:port_name] && @port = @switch.ports.where(name: params[:port_name]).first

        respond_to do |format|
          if @port.update(enabled_at: nil, disabled_at: DateTime.now.in_time_zone)
            DisablePortJob.perform_later(@port)

            GoatLogger.call("Port #{@port.name} on switch #{@switch.name} disabled.")

            flash[:message] = "Port was disabled"
            format.html { redirect_to switch_path @port.switch }

            # format.json { render :show, status: :ok, location: @port.switch }
            format.json { render json: {success: message} }
          else
            format.html { redirect_to switch_path @port.switch, status: :unprocessable_entity }
            format.json { render json: {error: message}, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  private

    def port_params
      params.require(:port).permit(:port_number, :switch_ip)
    end
end
