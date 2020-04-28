require 'rails_helper'

feature 'User create a customer' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@mail.com', password: '123456')
    customer = Customer.create!(name: 'William', email: 'teste@mail.com', document: '447.106.880-60')

    login_as user, scope: :user
    visit root_path
    click_on 'Criar conta'
    fill_in 'Nome', with: customer.name
    fill_in 'E-mail', with: customer.email
    fill_in 'CPF', with: customer.document
    click_on 'Enviar'

    expect(page).to have_content('Seu perfil')
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(customer.document)
  end
end
