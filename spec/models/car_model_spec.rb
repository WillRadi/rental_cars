require 'rails_helper'

RSpec.describe CarModel, type: :model do
  it 'should validate name presence' do
    car_model = CarModel.new(name: '')
    car_model.valid?

    expect(car_model.errors[:name]).to include 'não pode ficar em branco'
  end

  it 'should validate manufacturer presence' do
    car_model = CarModel.new(manufacturer: nil)
    car_model.valid?

    expect(car_model.errors[:manufacturer]).to include 'é obrigatório(a)'
  end

  it 'should validate car category presence' do
    car_model = CarModel.new(car_category: nil)
    car_model.valid?

    expect(car_model.errors[:car_category]).to include 'é obrigatório(a)'
  end
end
