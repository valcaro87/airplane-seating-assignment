class AirplanesController < ApplicationController
  before_action :validate_2d_array_num_passengers

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
      windw << @prepared_seats[0].collect { |r| r[0] }
      windw << @prepared_seats[-1].collect { |r| r[-1] }

      temp_aisle = []
      @prepared_seats.each do |gs|
        temp_aisle << gs.collect { |r| r[0] }
        temp_aisle << gs.collect { |r| r[-1] }
      end
      aisle = temp_aisle - windw

      set_aisle = seat_fillers(aisle, 0, "aisle")
      aisle_last_seat = set_aisle.present? ? set_aisle.values.last[0] : 0

      set_window = seat_fillers(windw, aisle_last_seat, "window")
      windw_last_seat = set_window.values.last[0]

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

  private

  def validate_2d_array_num_passengers
    begin
      arr = JSON.parse(params[:seat_array])
      no_passengers = Integer(params[:no_passengers]) rescue 0
      if arr.all? { |e| e.class==Array } && arr.map(&:size).uniq.size == 1 && no_passengers > 0
        @passengers_queue = no_passengers.to_i
        @given_seats = arr
        @valid_inputs = true
      else
        @valid_inputs = false
      end
    rescue
      @valid_inputs = false
    end
  end

  def seat_fillers(fill, last_seat = 0, description)
    last_val = fill.map(&:length).max
    fill = fill.map { |e| e.values_at(0...last_val) }.transpose.flatten.compact
    Hash[fill.each.with_index(last_seat + 1).map { |x, i| [x, [i,"#{description}"]] }]
  end

end
