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
    expect(page).to have_content('Fabricantes')
    expect(page).to have_content('Filiais')
    expect(page).to have_content('Categorias de Carros')
    expect(page).to have_content('Modelos')
    expect(page).to have_content('Locações')
    expect(page).to have_content('Frota de veículos')
  end
end
