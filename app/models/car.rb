class Car < ApplicationRecord
  belongs_to :car_model

  validates :license_plate, presence: true
  validates :license_plate, uniqueness: true
  validates :color, presence: true
  validates :mileage, presence: true
  validates :mileage, numericality: { greater_than: 0, only_integer: true }
end
