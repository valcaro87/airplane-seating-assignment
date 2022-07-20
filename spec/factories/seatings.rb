FactoryBot.define do
  factory :seating do
    given_seats { '[[1,2],[3,4]]' }
    passengers  { 22 }
    airplane

    factory :seating_examples_valid do
      given_seats { '[[1,2],[3,4]]' }
      passengers  { 14 }
      airplane
    end

    factory :seating_examples_invalid do
      given_seats { '[[2],[3,4]]' }
      passengers  { '1z' }
      airplane
    end

    factory :valid_number_of_passengers do
      given_seats { '[[3,2], [4,3], [2,3], [3,4]]' }
      passengers  { 36 }
      airplane
    end

    factory :invalid_number_of_passengers do
      given_seats { '[[3,2], [4,3], [2,3], [3,4]]' }
      passengers  { 37 }
      airplane
    end

    factory :invalid_given_seats_array_01 do
      given_seats { '[[0,2], [4,3], [2,3], [3,4]]' }
      passengers  { 3 }
      airplane
    end

    factory :invalid_given_seats_array_02 do
      given_seats { '[[0,2], [], [2,3], [3,4]]' }
      passengers  { 15 }
      airplane
    end

  end
end
