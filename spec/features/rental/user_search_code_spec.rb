require 'rails_helper'

feature 'User search rental by code' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@mail.com', password: '123456')
    car_category = CarCategory.create!(name: 'A', daily_rate: '100', car_insurance: '20', third_party_insurance: '20')
    customer = Customer.create!(name: 'Fulano da Silva', document: '363.550.460-20', email: 'teste@mail.com')
    rental = Rental.create!(start_date: '16/04/2030', end_date: '18/04/2030', customer: customer, car_category: car_category)
    rental_2 = Rental.create!(start_date: '16/04/2030', end_date: '18/04/2030', customer: customer, car_category: car_category)

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    fill_in 'Busca', with: rental.code
    click_on 'Pesquisar'

    expect(page).to have_content(rental.code)
    expect(page).not_to have_content(rental_2.code)
  end

  scenario 'and start a rental from search' do
    user = User.create!(email: 'test@test.com', password: '12345678')
    car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 100, third_party_insurance: 100)
    fiat = Manufacturer.create!(name: 'Fiat')
    mobi = CarModel.create!(name: 'Mobi', manufacturer: fiat, car_category: car_category)
    car = Car.create(car_model: mobi, license_plate: 'ABC-1234', mileage: 1000, color: 'Azul', status: :available)
    customer = Customer.create!(name: 'Fulano Sicrano', document: '57810023594', email: 'teste@teste.com.br')
    rental = Rental.create!(start_date: '16/04/2030', end_date: '18/04/2030', customer: customer, car_category: car_category)

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    fill_in 'Busca', with: rental.code
    click_on 'Pesquisar'
    click_on rental.code
    click_on 'Iniciar Locação'
    select 'Fiat Mobi - Placa: ABC-1234 - Cor: Azul', from: 'Carro'
    travel_to Time.zone.local(2020, 05, 02, 23, 00, 00) do
      click_on 'Confirmar'
    end

    rental.reload
    car.reload
    expect(rental.ongoing?).to be true
    expect(car.rented?).to be true
    expect(current_path).to eq rental_path(rental.id)
    expect(page).to have_content 'Status Iniciada'
    expect(page).to have_content 'Fulano Sicrano'
    expect(page).to have_content "Horário da Retirada 02/05/2020 23:00:00"
    expect(page).to have_content 'Usuário Responsável test@test.com'
    expect(page).to have_content 'Veículo Fiat Mobi - Placa: ABC-1234 - Cor: Azul'
  end
end
