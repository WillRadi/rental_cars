require 'rails_helper'

feature 'Admin register a new car' do
  scenario 'successfully' do
    manufacturer = Manufacturer.create!(name: 'Fiat')
    category = CarCategory.create!(name: 'A', daily_rate: '30', car_insurance: '10', third_party_insurance: '20')
    car_model = CarModel.create!(name: 'Uno', manufacturer: manufacturer, car_category: category, fuel_type: 'Flex', motorization: '1.0', year: '2020')

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
end
