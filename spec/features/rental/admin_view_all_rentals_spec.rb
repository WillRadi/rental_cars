require 'rails_helper'

feature 'Admim view rental' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@mail.com', password: '123456')
    car_category = CarCategory.create!(name: 'A', daily_rate: '100', car_insurance: '20', third_party_insurance: '20')
    customer = Customer.create!(name: 'Fulano da Silva', document: '363.550.460-20', email: 'teste@mail.com')
    Rental.create!(start_date: '16/04/2030', end_date: '18/04/2030', customer: customer, car_category: car_category)

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'

    expect(page).to have_content('16/04/2030')
    expect(page).to have_content('18/04/2030')
    expect(page).to have_content(customer.identification)
    expect(page).to have_content(/A/)
  end

  scenario 'and dont have any' do
    user = User.create!(email: 'teste@mail.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'

    expect(page).to have_content('Nenhum(a) Locação encontrado(a)')
  end
end
