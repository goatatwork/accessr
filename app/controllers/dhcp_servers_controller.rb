class DhcpServersController < ApplicationController
  before_action :set_dhcp_server, only: %i[ show edit update destroy ]

  # GET /dhcp_servers or /dhcp_servers.json
  def index
    @dhcp_servers = DhcpServer.all
  end

  # GET /dhcp_servers/1 or /dhcp_servers/1.json
  def show
  end

  # GET /dhcp_servers/new
  def new
    @dhcp_server = DhcpServer.new
  end

  # GET /dhcp_servers/1/edit
  def edit
  end

  # POST /dhcp_servers or /dhcp_servers.json
  def create
    @dhcp_server = DhcpServer.new(dhcp_server_params)

    respond_to do |format|
      if @dhcp_server.save
        format.html { redirect_to @dhcp_server, notice: "Dhcp server was successfully created." }
        format.json { render :show, status: :created, location: @dhcp_server }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dhcp_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dhcp_servers/1 or /dhcp_servers/1.json
  def update
    respond_to do |format|
      if @dhcp_server.update(dhcp_server_params)
        format.html { redirect_to @dhcp_server, notice: "Dhcp server was successfully updated." }
        format.json { render :show, status: :ok, location: @dhcp_server }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dhcp_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dhcp_servers/1 or /dhcp_servers/1.json
  def destroy
    @dhcp_server.destroy
    respond_to do |format|
      format.html { redirect_to dhcp_servers_url, notice: "Dhcp server was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dhcp_server
      @dhcp_server = DhcpServer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dhcp_server_params
      params.require(:dhcp_server).permit(:name, :server_type)
    end
end
