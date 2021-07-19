class SubscriberIdApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update
    if params[:switch_ip] && @switch = Switch.where(management_ip: params[:switch_ip]).first
      if params[:port_name] && @port = @switch.ports.where(name: params[:port_name]).first

        respond_to do |format|
          if @port.update(subscriber_id: params[:subscriber_id])

            SetPortSubscriberIdJob.perform_later(@port, params[:subscriber_id])

            flash[:message] = "The subscriber_id was updated."
            format.html { redirect_to port_path @port }

            # format.json { render :show, status: :ok, location: @port.switch }
            format.json { render json: {success: message} }
          else
            format.html { redirect_to port_path @port, status: :unprocessable_entity }
            format.json { render json: {error: message}, status: :unprocessable_entity }
          end
        end


      end
    end

    GoatLogger.call("Set subscriber id to #{params[:subscriber_id]} for port #{params[:port_name]} on switch #{params[:switch_ip]}")
  end
end
