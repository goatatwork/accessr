class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]

  def new
    @room = Room.find_by_id(params[:room_id])
    @message = Message.new
  end

  def edit
  end

  def create
    if params[:room_id] && @room = Room.find_by_id(params[:room_id])
      @message = @room.messages.new(message_params)
    end

    respond_to do |format|
      if @message.save
        format.html { redirect_to @room, notice: "Message was successfully created." }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:content)
    end
end
