class IpsController < ApplicationController
  before_action :set_ip, only: %i[ show edit update destroy ]

  # GET /ips or /ips.json
  def index
    if params[:pool_id] && @pool = Pool.find_by_id(params[:pool_id])
      @ips = @pool.ips
    else
      @ips = Ip.all
    end
  end

  # GET /ips/1 or /ips/1.json
  def show
  end

  # GET /ips/new
  def new
    @pool = Pool.find_by_id(params[:pool_id])
    @ip = Ip.new
  end

  # GET /ips/1/edit
  def edit
  end

  # POST /ips or /ips.json
  def create
    if params[:pool_id] && @pool = Pool.find_by_id(params[:pool_id])
      @ip = @pool.ips.new(ip_params)
    end

    respond_to do |format|
      if @ip.save
        format.html { redirect_to @ip, notice: "Ip was successfully created." }
        format.json { render :show, status: :created, location: @ip }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ips/1 or /ips/1.json
  def update
    respond_to do |format|
      if @ip.update(ip_params)
        format.html { redirect_to @ip, notice: "Ip was successfully updated." }
        format.json { render :show, status: :ok, location: @ip }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ips/1 or /ips/1.json
  def destroy
    @ip.destroy
    respond_to do |format|
      format.html { redirect_to ips_url, notice: "Ip was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ip
      @ip = Ip.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ip_params
      params.require(:ip).permit(:address, :pool_id)
    end
end
