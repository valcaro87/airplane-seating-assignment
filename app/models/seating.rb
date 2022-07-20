class Seating < ApplicationRecord
  belongs_to :airplane

  validates :given_seats, presence: true, allow_blank: false
  validates :passengers, presence: true, allow_blank: false, numericality: { only_integer: true}

  validate :valid_array, :max_seats, on: :create

  def valid_array
    arr = JSON.parse(self.given_seats)
    if arr.all? { |e| e.class==Array } && arr.map(&:size).uniq.size == 1 && !(arr.flatten.chunk(&:zero?).count(&:first)> 0)
      true
    else
      errors.add(:given_seats, "Please provide a valid 2D")
    end
  rescue
    errors.add(:given_seats, "Please provide a valid 2D")
  end

  def max_seats
    arr = JSON.parse(self.given_seats)
    passengers = (self.passengers).to_i
    max_seats = (arr.map { |x| x.inject(:*)}).sum
    if passengers <= max_seats
      true
    else
      errors.add(:passengers, "Number of passengers allowed capacity should be #{max_seats}")
    end
  rescue
    errors.add(:given_seats, "Please provide correct passengers")
  end

end
