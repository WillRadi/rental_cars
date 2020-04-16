require 'rails_helper'

feature 'Admin register new car model' do
  scenario 'successfully' do
    # Arrange
    Manufacturer.create!(name: 'Chevrolet')
    CarCategory.create!(name: 'B', daily_rate: '50', car_insurance: '20', third_party_insurance: '20')

    # Act
    visit root_path
    click_on 'Modelos'
    click_on 'Cadastrar novo modelo'

    fill_in 'Nome', with: 'Onix'
    select 'Chevrolet', from: 'Fabricante'
    fill_in 'Combustível', with: 'Flex'
    fill_in 'Motor', with: '1.0'
    fill_in 'Ano', with: '2020'
    select 'B', from: 'Categoria'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Onix')
    expect(page).to have_content('Fabricante: Chevrolet')
    expect(page).to have_content('Combustível: Flex')
    expect(page).to have_content('Motor: 1.0')
    expect(page).to have_content('Ano: 2020')
    expect(page).to have_content('Categoria: B')
  end
end
