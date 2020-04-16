require 'rails_helper'

feature 'Admim view rental' do
  scenario 'successfully' do
    car_category = CarCategory.create!(name: 'A', daily_rate: '100', car_insurance: '20', third_party_insurance: '20')
    client = Client.create!(name: 'Fulano da Silva', document: '12345678', email: 'teste@mail.com')
    Rental.create!(start_date: '16/04/2030', end_date: '18/04/2030', client: client, car_category: car_category)

    visit root_path
    click_on 'Locações'

    expect(page).to have_content('16/04/2030')
    expect(page).to have_content('18/04/2030')
    expect(page).to have_content('Fulano da Silva')
    expect(page).to have_content(/A/)
  end

  xscenario 'and dont have any' do
  end
end
