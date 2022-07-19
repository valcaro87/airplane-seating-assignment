        @temp_aisle << gs.collect { |r|  r[0] } #if @given_seats[0][0].to_i > 1
        @temp_aisle << gs.collect { |r| r[-1] } #if @given_seats[-1][0].to_i > 1 && @given_seats[-1][1].to_i > 1



@temp_aisle <%=@temp_aisle %> <br /> <br />
@aisle <%=@aisle %> <br /> <br />
set_aisle <%=@set_aisle %> <br /> <br />
@windw<%=@windw %> <br /> <br />
set_window<%=@set_window %> <br /> <br />
set_middle<%=@set_middle %> <br /> <br />
prepared_seats<%=@prepared_seats %> <br /> <br />
given_seats<%=@given_seats %> <br /> <br />
given_seats<%# =@given_seats[-1][0].to_i %> <br /> <br />
all_data<%=@all_data %> <br /> <br />
