require 'rails_helper'

feature 'Admin register rental' do
  scenario 'successfully' do
    car_category = CarCategory.create!(name: 'A', daily_rate: '100', car_insurance: '20', third_party_insurance: '20')
    client = Client.create!(name: 'Fulano da Silva', document: '363.550.460-20', email: 'teste@mail.com')

    visit root_path
    click_on 'Locações'
    click_on 'Registrar locação'
    fill_in 'Data inicial', with: '16/04/2030'
    fill_in 'Data final', with: '18/04/2030'
    select car_category.name, from: 'Categoria'
    select client.identification, from: 'Cliente'
    click_on 'Enviar'

    expect(page).to have_content('16/04/2030')
    expect(page).to have_content('18/04/2030')
    expect(page).to have_content(client.identification)
    expect(page).to have_content(/A/)
  end
end
