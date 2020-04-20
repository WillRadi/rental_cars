require 'rails_helper'

RSpec.describe Car, type: :model do
  it 'should validate license_plate presence' do
    car = Car.new(license_plate: '')
    car.valid?

    expect(car.errors[:license_plate]).to include 'não pode ficar em branco'
  end

  it 'should validate color presence' do
    car = Car.new(color: '')
    car.valid?

    expect(car.errors[:color]).to include 'não pode ficar em branco'
  end

  it 'should validate mileage presence' do
    car = Car.new(mileage: '')
    car.valid?

    expect(car.errors[:mileage]).to include 'não pode ficar em branco'
  end

  it 'should validate license_plate uniqueness' do
    manufacturer = Manufacturer.create!(name: 'Fiat')
    category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 10, third_party_insurance: 20)
    car_model = CarModel.create!(name: 'Uno', manufacturer: manufacturer, car_category: category, fuel_type: 'Flex', motorization: '1.0', year: 2020)

    car_v = Car.create!(car_model: car_model, license_plate: 'JRZ-2472', color: 'Verde', mileage: 20000)
    car_i = Car.new(license_plate: 'JRZ-2472')
    car_i.valid?

    expect(car_i.errors[:license_plate]).to include 'já está em uso'
  end

  it 'should validate greater than zero' do
    car = Car.new(mileage: 0)
    car.valid?

    expect(car.errors[:mileage]).to include 'deve ser maior que 0'
  end

  it 'should validate greater than negative' do
    car = Car.new(mileage: -1)
    car.valid?

    expect(car.errors[:mileage]).to include 'deve ser maior que 0'
  end

  xit 'should validate integer' do
    car = Car.new(mileage: 0.5)
    car.valid?

    expect(car.errors[:mileage]).to include 'deve ser maior que 0'
  end

  it 'mileage should be valid' do
    car = Car.new(mileage: 500)
    car.valid?

    expect(car.errors[:mileage]).to be_blank
  end
end
