class SubnetsController < ApplicationController
  before_action :set_subnet, only: %i[ show edit update destroy ]

  # GET /subnets or /subnets.json
  def index
    @subnets = Subnet.all
  end

  # GET /subnets/1 or /subnets/1.json
  def show
  end

  # GET /subnets/new
  def new
    @subnet = Subnet.new
  end

  # GET /subnets/1/edit
  def edit
  end

  # POST /subnets or /subnets.json
  def create
    @subnet = Subnet.new(subnet_params)

    respond_to do |format|
      if @subnet.save
        format.html { redirect_to @subnet, notice: "Subnet was successfully created." }
        format.json { render :show, status: :created, location: @subnet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subnet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subnets/1 or /subnets/1.json
  def update
    respond_to do |format|
      if @subnet.update(subnet_params)
        format.html { redirect_to @subnet, notice: "Subnet was successfully updated." }
        format.json { render :show, status: :ok, location: @subnet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subnet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subnets/1 or /subnets/1.json
  def destroy
    @subnet.destroy
    respond_to do |format|
      format.html { redirect_to subnets_url, notice: "Subnet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subnet
      @subnet = Subnet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subnet_params
      params.require(:subnet).permit(:name, :network_address, :cidr, :shared_network_id)
    end
end
