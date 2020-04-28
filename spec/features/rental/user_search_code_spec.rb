require 'rails_helper'

feature 'User search rental by code' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@mail.com', password: '123456')
    car_category = CarCategory.create!(name: 'A', daily_rate: '100', car_insurance: '20', third_party_insurance: '20')
    client = Client.create!(name: 'Fulano da Silva', document: '363.550.460-20', email: 'teste@mail.com')
    rental = Rental.create!(start_date: '16/04/2030', end_date: '18/04/2030', client: client, car_category: car_category)
    rental_2 = Rental.create!(start_date: '16/04/2030', end_date: '18/04/2030', client: client, car_category: car_category)

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    fill_in 'Busca', with: rental.code
    click_on 'Pesquisar'

    expect(page).to have_content(rental.code)
    expect(page).not_to have_content(rental_2.code)
  end
end
