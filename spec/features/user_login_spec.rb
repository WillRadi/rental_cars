require 'rails_helper'

feature 'user login' do
  scenario 'successfully' do
    # User != Client
    user = User.create!(email: 'teste@mail.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'teste@mail.com'
    fill_in 'Senha', with: '123456'
    click_on 'Log in'

    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).to have_link('Fabricantes')
    expect(page).to have_link('Filiais')
    expect(page).to have_link('Categorias de Carros')
    expect(page).to have_link('Modelos')
    expect(page).to have_link('Locações')
    expect(page).to have_link('Frota de veículos')
    expect(page).to have_link('Logout')
    expect(page).not_to have_link('Entrar')
  end

  scenario 'and user log out' do
    user = User.create!(email: 'teste@mail.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'teste@mail.com'
    fill_in 'Senha', with: '123456'
    click_on 'Log in'
    click_on 'Logout'

    expect(page).to have_content('Saiu com sucesso.')
    expect(page).not_to have_link('Criar conta')
    expect(page).not_to have_link('Fabricantes')
    expect(page).not_to have_link('Filiais')
    expect(page).not_to have_link('Categorias de Carros')
    expect(page).not_to have_link('Modelos')
    expect(page).not_to have_link('Locações')
    expect(page).not_to have_link('Frota de veículos')
    expect(page).not_to have_link('Logout')
    expect(page).to have_link('Entrar')
  end
end
