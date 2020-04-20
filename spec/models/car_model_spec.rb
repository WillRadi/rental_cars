require 'rails_helper'

RSpec.describe CarModel, type: :model do
  it 'should validate presence' do
    car_model = CarModel.new(name: '')
    car_model.valid?

    expect(car_model.errors[:name]).to include 'não pode ficar em branco'
  end
end
