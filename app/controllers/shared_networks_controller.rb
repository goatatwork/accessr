class SharedNetworksController < ApplicationController
  before_action :set_shared_network, only: %i[ show edit update destroy ]

  # GET /shared_networks or /shared_networks.json
  def index
    @shared_networks = SharedNetwork.all
  end

  # GET /shared_networks/1 or /shared_networks/1.json
  def show
  end

  # GET /shared_networks/new
  def new
    @shared_network = SharedNetwork.new
  end

  # GET /shared_networks/1/edit
  def edit
  end

  # POST /shared_networks or /shared_networks.json
  def create
    @shared_network = SharedNetwork.new(shared_network_params)

    respond_to do |format|
      if @shared_network.save
        format.html { redirect_to @shared_network, notice: "Shared network was successfully created." }
        format.json { render :show, status: :created, location: @shared_network }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shared_network.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shared_networks/1 or /shared_networks/1.json
  def update
    respond_to do |format|
      if @shared_network.update(shared_network_params)
        format.html { redirect_to @shared_network, notice: "Shared network was successfully updated." }
        format.json { render :show, status: :ok, location: @shared_network }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shared_network.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shared_networks/1 or /shared_networks/1.json
  def destroy
    @shared_network.destroy
    respond_to do |format|
      format.html { redirect_to shared_networks_url, notice: "Shared network was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shared_network
      @shared_network = SharedNetwork.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shared_network_params
      params.require(:shared_network).permit(:name, :relayed_from_ip, :dhcp_server_id)
    end
end
