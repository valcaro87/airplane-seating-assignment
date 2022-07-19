class Seating < ApplicationRecord
  belongs_to :airplane

  validates :given_seats, presence: true, allow_blank: false
  validates :passengers, presence: true, allow_blank: false
end
