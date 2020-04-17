require 'rails_helper'

feature 'User create a client' do
  scenario 'successfully' do
    client = Client.create!(name: 'William', email: 'teste@mail.com', document: '447.106.880-60')

    visit root_path
    click_on 'Criar conta'
    fill_in 'Nome', with: client.name
    fill_in 'E-mail', with: client.email
    fill_in 'CPF', with: client.document
    click_on 'Enviar'

    expect(page).to have_content('Seu perfil')
    expect(page).to have_content(client.name)
    expect(page).to have_content(client.email)
    expect(page).to have_content(client.document)
  end
end
