require 'rails_helper'

feature 'Administrator register a new subsidiary' do
  scenario 'access from index page' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_link('Registrar nova filial', href: new_subsidiary_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'São Paulo'
    fill_in 'CNPJ', with: '123456789'
    fill_in 'Endereço', with: 'Avenida Paulista, 123'

    click_on 'Enviar'

    expect(page).to have_content('São Paulo')
    expect(page).to have_content('CNPJ: 123456789')
    expect(page).to have_content('Endereço: Avenida Paulista, 123')
  end
end
