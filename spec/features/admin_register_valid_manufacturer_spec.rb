require 'rails_helper'

feature 'Admin register valid manufacturer' do
  scenario 'and name must be unique' do
    user = User.create!(email: 'teste@mail.com', password: '123456')
    Manufacturer.create(name: 'Fiat' )

    login_as user, scope: :user
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(Manufacturer.count).to eq 1
    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'and name can not be blank' do
    user = User.create!(email: 'teste@mail.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'

    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(Manufacturer.count).to eq 0
    expect(page).to have_content('Nome não pode ficar em branco')
  end

end

