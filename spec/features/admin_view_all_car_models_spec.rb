require 'rails_helper'

feature 'Admin view all car models' do
  scenario 'successfully' do
    # Arrange
    user = User.create!(email: 'teste@mail.com', password: '123456')
    fiat = Manufacturer.create!(name: 'Fiat')
    gm = Manufacturer.create!(name: 'Chevrolet')
    cat_a = CarCategory.create!(name: 'A', daily_rate: '30', car_insurance: '10', third_party_insurance: '20')
    cat_b = CarCategory.create!(name: 'B', daily_rate: '50', car_insurance: '20', third_party_insurance: '20')

    CarModel.create!(name: '147', manufacturer: fiat, car_category: cat_a)
    CarModel.create!(name: 'Onix', manufacturer: gm, car_category: cat_b)

    # Act
    login_as user, scope: :user
    visit root_path
    click_on 'Modelos'

    # Assert
    expect(page).to have_content('147')
    expect(page).to have_content('Fiat')
    expect(page).to have_content('A')
    expect(page).to have_content('Onix')
    expect(page).to have_content('Chevrolet')
    expect(page).to have_content('B')
  end

  scenario 'and have no car model created' do
    user = User.create!(email: 'teste@mail.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Modelos'

    expect(page).to have_content('Nenhum(a) Modelo de carro encontrado(a)')
  end
end
