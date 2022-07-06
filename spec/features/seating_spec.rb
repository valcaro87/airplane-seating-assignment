require "rails_helper"

describe "User submit inputs", type: :feature do
  context "check if input arguments are valid or not" do
    before(:each) do
      visit airplane_seating_path
    end

    context "when all inputs are valid" do
      test_data = [[[1, 1],[1, 1],[2,1]],4],
        [[[1, 1],[1, 1],[1,1]],3],
        [[[1, 1],[1, 1]],2],
        [[[2, 1],[1, 8],[1,1]], 11],
        [[[2, 8],[3, 8],[2,1]],42],
        [[[3,2], [4,3], [2,3], [3,4]], 30],
        [[[1,1],[1,1]],2],
        [[[2,1],[2,1]],3],
        [[[2, 2], [2, 2],[1,8]],16],
        [[[1, 7], [4, 2],[1,8],[1,8]],26]

      test_data.each do |arr, num_passenger|
        it "should be successful" do
          fill_in "Column/Rows:", with: "#{arr}"
          fill_in "Number of passengers:", with: "#{num_passenger}"
          click_button "Submit"
          expect(page).to have_content("Airplane seats generated")
        end
      end
    end

    context "when any of the inputs are invalid" do
      it "should return an error" do
        fill_in "Column/Rows:", with: "a[[3,2], [4,3], [2,3], [3,4]]"
        fill_in "Number of passengers:", with: "15a"
        click_button "Submit"
        expect(page).to have_content("Please provide a valid 2D array and Number of passengers")
      end
    end

    context "if passengers are more than the seat capacity" do
      it "should return an error" do
        fill_in "Column/Rows:", with: "[[3,2], [4,3], [2,3], [3,4]]"
        fill_in "Number of passengers:", with: "37"
        click_button "Submit"
        expect(page).to have_content("Number of passengers allowed capacity should be 36")
      end
    end

    context "if sub-arrays contains any zero's" do
      it "should return an error" do
        fill_in "Column/Rows:", with: "[[3,2], [0,3], [2,3], [3,4]]"
        fill_in "Number of passengers:", with: "37"
        click_button "Submit"
        expect(page).to have_content("A 2D array should not contain any zero's")
      end
    end
  end
end
