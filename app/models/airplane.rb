class Airplane < ApplicationRecord
  has_many :seatings
  # accepts_nested_attributes_for :seatings

  validates :name, presence: true, allow_blank: false
  validates :model, presence: true, allow_blank: false

end
