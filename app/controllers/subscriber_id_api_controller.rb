class SubscriberIdApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update
    if params[:switch_ip] && @switch = Switch.where(management_ip: params[:switch_ip]).first
      if params[:port_name] && @port = @switch.ports.where(name: params[:port_name]).first

        SetPortSubscriberIdJob.perform_later(@port, params[:subscriber_id])
        render json: {success: "SetSubscriberIdJob in progress"}

      end
    end

    GoatLogger.call("Set subscriber id to #{params[:subscriber_id]} for port #{params[:port_name]} on switch #{params[:switch_ip]}")
  end
end
