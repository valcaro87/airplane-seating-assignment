class AirplanesController < ApplicationController


  def seating
    # given_array =
    @given_seats = JSON.parse(params[:seat_array])
    @passengers_queue = params[:no_passengers].to_i

    # given_seats = [[3, 2], [4, 3], [2, 3], [3, 4]]
    # given_seats = [[3,4], [4,5], [2,3], [3,4]]
    # given_seats = [[2, 8], [3, 8], [2, 8]]
    # given_seats = [[2, 8], [3, 8]]
    if @given_seats.present? && @passengers_queue
      @no_groups = @given_seats.count


      ss = []

      @given_seats.each.with_index(1) do |x, i|
        t = x[0] * x[1]
        pg = []
        (1..t).each do |ps|
          pg << "#{i}-#{ps}"
        end
        ss << pg.flatten.each_slice(x[0]).to_a
      end

      @prepared_seats = ss
      @test = Hash[ss.collect { |x| [x] }]

      windw = []
      windw << ss[0].collect { |r| r[0] }
      windw << ss[-1].collect { |r| r[-1] }

      temp_aisle = []
      ss.each do |gs|
        temp_aisle << gs.collect { |r| r[0] }
        temp_aisle << gs.collect { |r| r[-1] }
      end
      aisle = temp_aisle - windw
      l = aisle.map(&:length).max
      aisle = aisle.map { |e| e.values_at(0...l) }.transpose.flatten.compact

      # p '----------------------aisle-------------------------'
      @aisle = Hash[aisle.each.with_index(1).map { |x, i| [x, [i,"aisle"]] }]
      aisle_last_seat = @aisle.values.last[0]

      # p '----------------------windw-------------------------'
      l = windw.map(&:length).max
      windw = windw.map { |e| e.values_at(0...l) }.transpose.flatten.compact
      @windw = Hash[windw.each.with_index(aisle_last_seat + 1).map { |x, i| [x, [i, "window"]] }]
      windw_last_seat = @windw.values.last[0]

      middlez = []
      ss.each.with_index do |gs, i|
        pq = (1..@given_seats[i][0]).to_a[1...-1]
        if pq.size > 0
          pq.each do |rz|
            middlez << gs.collect { |r| r[rz - 1] }
          end
        end
      end

      l = middlez.map(&:length).max
      middlez = middlez.map { |e| e.values_at(0...l) }.transpose.flatten.compact
      @middlez = Hash[middlez.each.with_index(windw_last_seat + 1).map { |x, i| [x, [i, "middle"]] }]

      @all_data = [*@aisle,*@windw,*@middlez].to_h
    end
  end

end
