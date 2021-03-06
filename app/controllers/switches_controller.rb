class SwitchesController < ApplicationController
  before_action :set_switch, only: %i[ show edit update destroy ]

  # GET /switches or /switches.json
  def index
    @switch_config = SwitchConfig.new
    @switches = Switch.all
  end

  # GET /switches/1 or /switches/1.json
  def show
  end

  # GET /switches/new
  def new
    @switch = Switch.new
  end

  # GET /switches/1/edit
  def edit
  end

  # POST /switches or /switches.json
  def create
    @switch = Switch.new(switch_params)

    respond_to do |format|
      if @switch.save

        if params[:look_for_ports_via_snmp]
          @switch.add_ports_from_snmp
        end
        format.turbo_stream
        format.html { redirect_to @switch, notice: "Switch was successfully created." }
        format.json { render :show, status: :created, location: @switch }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @switch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /switches/1 or /switches/1.json
  def update
    respond_to do |format|
      if @switch.update(switch_params)
        format.html { redirect_to @switch, notice: "Switch was successfully updated." }
        format.json { render :show, status: :ok, location: @switch }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @switch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /switches/1 or /switches/1.json
  def destroy
    @switch.destroy
    respond_to do |format|
      format.html { redirect_to switches_url, notice: "Switch was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_switch
      @switch = Switch.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def switch_params
      params.require(:switch).permit(:name, :hostname, :manufacturer, :model, :management_ip, :snmp_community, :ssh_user, :ssh_password, :look_for_ports_via_snmp, config_backups: [])
    end
end
