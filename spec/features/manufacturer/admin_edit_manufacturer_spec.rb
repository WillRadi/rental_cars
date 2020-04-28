require 'rails_helper'

feature 'Admin edits manufacturer' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@mail.com', password: '123456')
    m = Manufacturer.create(name: 'Fiat')

    login_as user, scope: :user
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(current_path).to eq manufacturer_path(m.id)
    expect(page).to have_content('Honda')
    expect(page).not_to have_content('Fiat')
  end

  scenario 'and name cant be blank' do
    user = User.create!(email: 'teste@mail.com', password: '123456')
    Manufacturer.create(name: 'Fiat')

    login_as user, scope: :user
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'and name must be unique' do
    user = User.create!(email: 'teste@mail.com', password: '123456')
    Manufacturer.create(name: 'Fiat')
    Manufacturer.create(name: 'Honda')

    login_as user, scope: :user
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end
end
