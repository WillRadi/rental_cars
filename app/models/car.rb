class Car < ApplicationRecord
  belongs_to :car_model

  validates :license_plate, presence: true
  validates :color, presence: true
  validates :mileage, presence: true
end
