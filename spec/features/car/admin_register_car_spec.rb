require 'rails_helper'

feature 'Admin register a new car' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@mail.com', password: '123456')
    manufacturer = Manufacturer.create!(name: 'Fiat')
    category = CarCategory.create!(name: 'A', daily_rate: '30', car_insurance: '10', third_party_insurance: '20')
    car_model = CarModel.create!(name: 'Uno', manufacturer: manufacturer, car_category: category, fuel_type: 'Flex', motorization: '1.0', year: '2020')

    login_as user, scope: :user
    visit root_path
    click_on 'Frota de veículos'
    click_on 'Cadastrar novo veículo'

    select car_model.manufacturer_and_name, from: 'Modelo'
    fill_in 'Placa', with: 'AUK-3055'
    fill_in 'Cor', with: 'Amarelo'
    fill_in 'Quilometragem', with: '70000'
    click_on 'Enviar'

    expect(page).to have_content("#{car_model.manufacturer_and_name} - AUK-3055")
    expect(page).to have_content('Amarelo')
    expect(page).to have_content('70000')
  end

  scenario 'and fields cant be blank' do
    user = User.create!(email: 'teste@mail.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Frota de veículos'
    click_on 'Cadastrar novo veículo'
    click_on 'Enviar'

    expect(Car.count).to eq 0
    expect(page).to have_content('Modelo é obrigatório(a)')
    expect(page).to have_content('Placa não pode ficar em branco')
    expect(page).to have_content('Cor não pode ficar em branco')
    expect(page).to have_content('Quilometragem não pode ficar em branco')
  end

  scenario 'and license_plate is unique' do
    user = User.create!(email: 'teste@mail.com', password: '123456')
    manufacturer = Manufacturer.create!(name: 'Fiat')
    category = CarCategory.create!(name: 'A', daily_rate: '30', car_insurance: '10', third_party_insurance: '20')
    car_model = CarModel.create!(name: 'Uno', manufacturer: manufacturer, car_category: category, fuel_type: 'Flex', motorization: '1.0', year: '2020')
    car = Car.create!(car_model: car_model, license_plate: 'AUK-3055', mileage: '1000', color: 'Branco')

    login_as user, scope: :user
    visit root_path
    click_on 'Frota de veículos'
    click_on 'Cadastrar novo veículo'

    select car_model.manufacturer_and_name, from: 'Modelo'
    fill_in 'Placa', with: 'AUK-3055'
    fill_in 'Cor', with: 'Amarelo'
    fill_in 'Quilometragem', with: '70000'
    click_on 'Enviar'

    expect(page).to have_content('Placa já está em uso')
  end

  scenario 'and mileage cant be lass than zero' do
    user = User.create!(email: 'teste@mail.com', password: '123456')
    manufacturer = Manufacturer.create!(name: 'Fiat')
    category = CarCategory.create!(name: 'A', daily_rate: '30', car_insurance: '10', third_party_insurance: '20')
    car_model = CarModel.create!(name: 'Uno', manufacturer: manufacturer, car_category: category, fuel_type: 'Flex', motorization: '1.0', year: '2020')
    car = Car.create!(car_model: car_model, license_plate: 'AUK-3055', mileage: '1000', color: 'Branco')

    login_as user, scope: :user
    visit root_path
    click_on 'Frota de veículos'
    click_on 'Cadastrar novo veículo'

    select car_model.manufacturer_and_name, from: 'Modelo'
    fill_in 'Placa', with: 'AUK-3055'
    fill_in 'Cor', with: 'Amarelo'
    fill_in 'Quilometragem', with: '-1'
    click_on 'Enviar'

    expect(page).to have_content('Quilometragem deve ser maior que 0')
  end
end
