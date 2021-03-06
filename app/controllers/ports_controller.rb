class PortsController < ApplicationController
  before_action :set_port, only: %i[ show edit update destroy ]
  before_action :set_portable, only: %i[ new ]

  # GET /ports or /ports.json
  def index
    if params[:switch_id] && @switch = Switch.find_by_id(params[:switch_id])
      @ports = @switch.ports.order(:port_number)
    elsif params[:slot_id] && @slot = Slot.find_by_id(params[:slot_id])
      @ports = @slot.ports.order(:port_number)
    else
      @ports = Port.order(:port_number)
    end
  end

  # GET /ports/1 or /ports/1.json
  def show
  end

  # GET /ports/new
  def new
    @port = Port.new
  end

  # GET /ports/1/edit
  def edit
  end

  # POST /ports or /ports.json
  def create
    if params[:switch_id] && @switch = Switch.find_by_id(params[:switch_id])
      @port = @switch.ports.new(port_params)
    end

    if params[:slot_id] && @slot = Slot.find_by_id(params[:slot_id])
      @port = @slot.ports.new(port_params)
    end

    respond_to do |format|
      if @port.save
        format.html { redirect_to @port, notice: "Port was successfully created." }
        format.json { render :show, status: :created, location: @port }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @port.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ports/1 or /ports/1.json
  def update

    respond_to do |format|
      if @port.update(port_params)
        SetPortRateLimitJob.perform_later(@port)
        format.html { redirect_to @port, notice: "Port was successfully updated." }
        format.json { render :show, status: :ok, location: @port }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @port.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ports/1 or /ports/1.json
  def destroy
    @port.destroy
    respond_to do |format|
      format.html { redirect_to ports_url, notice: "Port was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_port
      @port = Port.find(params[:id])
    end

    def set_portable
      if params[:switch_id] && @switch = Switch.find_by_id(params[:switch_id])
        @portable = @switch
      end
      if params[:slot_id] && @slot = Slot.find_by_id(params[:slot_id])
        @portable = @slot
      end
    end

    # Only allow a list of trusted parameters through.
    def port_params
      params.require(:port).permit(:port_number, :name, :description, :up_rate, :down_rate, :rate_unit)
    end
end
