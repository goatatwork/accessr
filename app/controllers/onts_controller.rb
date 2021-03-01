class OntsController < ApplicationController
  before_action :set_ont, only: %i[ show edit update destroy ]

  # GET /onts or /onts.json
  def index
    @onts = Ont.all
  end

  # GET /onts/1 or /onts/1.json
  def show
  end

  # GET /onts/new
  def new
    @ont = Ont.new
  end

  # GET /onts/1/edit
  def edit
  end

  # POST /onts or /onts.json
  def create
    @ont = Ont.new(ont_params)

    respond_to do |format|
      if @ont.save
        format.html { redirect_to @ont, notice: "Ont was successfully created." }
        format.json { render :show, status: :created, location: @ont }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ont.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /onts/1 or /onts/1.json
  def update
    respond_to do |format|
      if @ont.update(ont_params)
        format.html { redirect_to @ont, notice: "Ont was successfully updated." }
        format.json { render :show, status: :ok, location: @ont }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ont.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /onts/1 or /onts/1.json
  def destroy
    @ont.destroy
    respond_to do |format|
      format.html { redirect_to onts_url, notice: "Ont was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ont
      @ont = Ont.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ont_params
      params.require(:ont).permit(:name, :manufacturer, :model)
    end
end
