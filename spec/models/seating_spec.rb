require 'rails_helper'

RSpec.describe Seating, type: :model do
  let!(:valid_seating) { FactoryBot.create(:seating_examples_valid) }

  context 'create new seating' do
    describe "with valid params" do
      it "successful 01" do
        seating = create(:seating_examples_valid)
        expect(seating.given_seats).to eq("[[1,2],[3,4]]")
      end

      it "successful 02" do
        seating = create(:seating_examples_valid, given_seats: "[[1, 1],[1, 1],[1,1]]", passengers: "3")
        expect(seating.given_seats).to eq("[[1, 1],[1, 1],[1,1]]")
      end
    end

    describe "with Invalid params array 01 and 02" do
      it "dont accept invalid array example 0" do
        expect {create(:seating_examples_invalid)}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Passengers is not a number, Given seats Please provide a valid 2D")
      end

      it "dont accept invalid example 01" do
        expect {create(:invalid_given_seats_array_01)}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Given seats Please provide a valid 2D")
      end

      it "dont accept invalid example 02" do
        expect {create(:invalid_given_seats_array_02)}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Given seats Please provide a valid 2D, Given seats Please provide correct passengers")
      end

      it "when array contains any zeros" do
        expect {
          create(
            :seating_examples_valid,
            given_seats: "[[3,2], [0,3], [2,3], [3,4]]"
          )}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Given seats Please provide a valid 2D")
      end
    end

    describe "number of passengers below or equal to max" do
      it "accepts allowed capacity" do
        seating = build(:valid_number_of_passengers)
        expect(seating.passengers).to eq(36)
      end
    end

    describe "number of passengers above max" do
      it "dont accept exceeded capacity" do
        expect {create(:invalid_number_of_passengers)}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Passengers Number of passengers allowed capacity should be 36")
      end
    end

  end
end
