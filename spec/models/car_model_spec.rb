require 'rails_helper'

RSpec.describe CarModel, type: :model do
  it 'should validate name presence' do
    car_model = CarModel.new(name: '')
    car_model.valid?

    expect(car_model.errors[:name]).to include 'não pode ficar em branco'
  end

  xit 'should validate manufacturer presence' do
    car_model = CarModel.new(manufacturer_id: '')
    car_model.valid?

    expect(car_model.errors[:manufacturer_id]).to include 'já está em uso'
  end

  xit 'should validate car category presence' do
    car_model = CarModel.new(car_category_id: '')
    car_model.valid?

    expect(car_model.errors[:car_category_id]).to include 'já está em uso'
  end
end
