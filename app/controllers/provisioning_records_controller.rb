class ProvisioningRecordsController < ApplicationController
  before_action :set_provisioning_record, only: %i[ show edit update destroy ]

  # GET /provisioning_records or /provisioning_records.json
  def index
    @provisioning_records = ProvisioningRecord.all
  end

  # GET /provisioning_records/1 or /provisioning_records/1.json
  def show
  end

  # GET /provisioning_records/new
  def new
    @provisioning_record = ProvisioningRecord.new
  end

  # GET /provisioning_records/1/edit
  def edit
  end

  # POST /provisioning_records or /provisioning_records.json
  def create
    @provisioning_record = ProvisioningRecord.new(provisioning_record_params)

    respond_to do |format|
      if @provisioning_record.save
        format.html { redirect_to @provisioning_record, notice: "Provisioning record was successfully created." }
        format.json { render :show, status: :created, location: @provisioning_record }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @provisioning_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /provisioning_records/1 or /provisioning_records/1.json
  def update
    respond_to do |format|
      if @provisioning_record.update(provisioning_record_params)
        format.html { redirect_to @provisioning_record, notice: "Provisioning record was successfully updated." }
        format.json { render :show, status: :ok, location: @provisioning_record }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @provisioning_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /provisioning_records/1 or /provisioning_records/1.json
  def destroy
    @provisioning_record.destroy
    respond_to do |format|
      format.html { redirect_to provisioning_records_url, notice: "Provisioning record was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provisioning_record
      @provisioning_record = ProvisioningRecord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def provisioning_record_params
      params.require(:provisioning_record).permit(:location_id, :port_id, :ip_id, :ont_id)
    end
end
