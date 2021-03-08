class SwitchConfigsController < ApplicationController
  before_action :set_switch_config, only: %i[ show edit update destroy ]

  # GET /switch_configs or /switch_configs.json
  def index
    if params[:switch_id] && @switch = Switch.find_by_id(params[:switch_id])
      @switch_configs = @switch.switch_configs
    end
    @switch_configs = SwitchConfig.all
  end

  # GET /switch_configs/1 or /switch_configs/1.json
  def show
  end

  # GET /switch_configs/new
  def new
    @switch = Switch.find_by_id(params[:switch_id])
    @switch_config = SwitchConfig.new
  end

  # GET /switch_configs/1/edit
  def edit
  end

  # POST /switch_configs or /switch_configs.json
  def create
    if params[:switch_id] && @switch = Switch.find_by_id(params[:switch_id])
      @switch_config = @switch.switch_configs.new(switch_config_params)
    end

    respond_to do |format|
      if @switch_config.save
        BackupSwitchConfigJob.perform_later(@switch, @switch_config)
        format.html { redirect_to @switch, notice: "Switch config was successfully created." }
        format.json { render :show, status: :created, location: @switch }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @switch_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /switch_configs/1 or /switch_configs/1.json
  def update
    respond_to do |format|
      if @switch_config.update(switch_config_params)
        format.html { redirect_to @switch_config, notice: "Switch config was successfully updated." }
        format.json { render :show, status: :ok, location: @switch_config }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @switch_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /switch_configs/1 or /switch_configs/1.json
  def destroy
    @switch_config.destroy
    respond_to do |format|
      format.html { redirect_to switch_configs_url, notice: "Switch config was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_switch_config
      @switch_config = SwitchConfig.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def switch_config_params
      params.require(:switch_config).permit(:name, :active, :switch_id)
    end
end
