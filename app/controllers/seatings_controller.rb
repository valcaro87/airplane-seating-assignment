class SeatingsController < ApplicationController
  before_action :set_seating, only: %i[ show edit update destroy ]

  # GET /seatings or /seatings.json
  def index
    @seatings = Seating.all
  end

  # GET /seatings/1 or /seatings/1.json
  def show
  end

  # GET /seatings/new
  def new
    @seating = Seating.new
  end

  # GET /seatings/1/edit
  def edit
  end

  # POST /seatings or /seatings.json
  def create
    @seating = Seating.new(seating_params)

    respond_to do |format|
      if @seating.save
        format.html { redirect_to seating_url(@seating), notice: "seating was successfully created." }
        format.json { render :show, status: :created, location: @seating }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @seating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seatings/1 or /seatings/1.json
  def update
    respond_to do |format|
      if @seating.update(seating_params)
        format.html { redirect_to seating_url(@seating), notice: "seating was successfully updated." }
        format.json { render :show, status: :ok, location: @seating }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @seating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seatings/1 or /seatings/1.json
  def destroy
    @seating.destroy

    respond_to do |format|
      format.html { redirect_to seatings_url, notice: "seating was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seating
      @seating = Seating.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def seating_params
      params.require(:seating).permit(:given_seats, :passengers)
    end
end


