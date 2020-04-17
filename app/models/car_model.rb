class CarModel < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :car_category

  def manufacturer_and_name
    "#{manufacturer.name} #{name}"
  end
end
