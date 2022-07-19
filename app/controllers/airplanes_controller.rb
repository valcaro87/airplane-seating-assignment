class AirplanesController < ApplicationController
  before_action :validate_2d_array_num_passengers, only: [:seating]
  before_action :set_airplane, only: %i[ show edit update destroy ]

  def seating
    if @valid_inputs
      @num_groups = @given_seats.count
      @prepared_seats = []

      @given_seats.each.with_index(1) do |x, i|
        t = x[0] * x[1]
        pg = []
        (1..t).each do |ps|
          pg << "#{i}-#{ps}"
        end
        @prepared_seats << pg.flatten.each_slice(x[0]).to_a
      end

      windw = []
      windw << @prepared_seats[0].collect { |r| r[0] } if @given_seats.first.first.to_i > 1
      windw << @prepared_seats[-1].collect { |r| r[-1] } if @given_seats.last.first.to_i > 1

      temp_aisle = []
      @prepared_seats.each do |gs|
        temp_aisle << gs.collect { |r| r[0] }
        temp_aisle << gs.collect { |r| r[-1] }
      end
      aisle = temp_aisle.uniq - windw.uniq

      set_aisle = seat_fillers(aisle, 0, "aisle")
      aisle_last_seat = set_aisle.present? ? set_aisle.values.last[0] : 0

      set_window = seat_fillers(windw, aisle_last_seat, "window")
      windw_last_seat = set_window.present? ? set_window.values.last[0] : aisle_last_seat

      middle = []
      @prepared_seats.each.with_index do |gs, i|
        pq = (1..@given_seats[i][0]).to_a[1...-1]
        if pq.size > 0
          pq.each do |rz|
            middle << gs.collect { |r| r[rz - 1] }
          end
        end
      end

      set_middle = seat_fillers(middle, windw_last_seat, "middle")

      @all_data = [*set_aisle,*set_window,*set_middle].to_h
    end
  end

  def index
    @airplanes = Airplane.all
  end

  # GET /airplanes/1 or /airplanes/1.json
  def show
  end

  # GET /airplanes/new
  def new
    @airplane = Airplane.new
  end

  # GET /airplanes/1/edit
  def edit
  end

  # POST /airplanes or /airplanes.json
  def create
    @airplane = Airplane.new(airplane_params)

    respond_to do |format|
      if @airplane.save
        format.html { redirect_to airplane_url(@airplane), notice: "Airplane was successfully created." }
        format.json { render :show, status: :created, location: @airplane }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @airplane.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /airplanes/1 or /airplanes/1.json
  def update
    respond_to do |format|
      if @airplane.update(airplane_params)
        format.html { redirect_to airplane_url(@airplane), notice: "Airplane was successfully updated." }
        format.json { render :show, status: :ok, location: @airplane }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @airplane.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /airplanes/1 or /airplanes/1.json
  def destroy
    @airplane.destroy

    respond_to do |format|
      format.html { redirect_to airplanes_url, notice: "Airplane was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def validate_2d_array_num_passengers
    flash[:alert] = []
    begin
      arr = JSON.parse(params[:seat_array])
      no_passengers = Integer(params[:no_passengers]) rescue 0
      if arr.all? { |e| e.class==Array } && arr.map(&:size).uniq.size == 1 && no_passengers > 0

        max_seats = (arr.map { |x| x.inject(:*)}).sum
        if arr.flatten.chunk(&:zero?).count(&:first)> 0
          flash[:alert] << "A 2D array should not contain any zero's"
          @valid_inputs = false
        elsif no_passengers > max_seats
          flash[:alert] << "Number of passengers allowed capacity should be #{max_seats}"
          @valid_inputs = false
        else
          @passengers_queue = no_passengers.to_i
          @given_seats = arr
          @valid_inputs = true
        end
      else
        flash[:alert] << "Please provide a valid 2D array and Number of passengers"
        @valid_inputs = false
      end
    rescue
      flash[:alert] << "Please provide a valid 2D array and Number of passengers"
      @valid_inputs = false
    end
  end

  def seat_fillers(fill, last_seat = 0, description)
    last_val = fill.map(&:length).max
    fill = fill.map { |e| e.values_at(0...last_val) }.transpose.flatten.compact
    Hash[fill.each.with_index(last_seat + 1).map { |x, i| [x, [i,"#{description}"]] }]
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_airplane
    @airplane = Airplane.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def airplane_params
    params.require(:airplane).permit(:name, :model)
  end

end
