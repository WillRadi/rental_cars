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

  scenario 'and edit a subsidiary' do
    s = Subsidiary.create!(name: 'São Paulo', cnpj: '123456789', address: 'Avenida Paulista, 123')

    visit root_path
    click_on 'Filiais'
    click_on 'São Paulo'
    click_on 'Editar'

    fill_in 'Nome', with: 'Rio Branco'
    fill_in 'CNPJ', with: '987654321'
    fill_in 'Endereço', with: 'Rua T-rex, 1234'
    click_on 'Enviar'

    expect(current_path).to eq subsidiary_path(s.id)
    expect(page).to have_content('Rio Branco')
    expect(page).not_to have_content('São Paulo')
    expect(page).to have_content('CNPJ: 987654321')
    expect(page).not_to have_content('CNPJ: 123456789')
    expect(page).to have_content('Endereço: Rua T-rex, 1234')
    expect(page).not_to have_content('Endereço: Avenida Paulista, 123')
  end

  scenario 'and cnpj cant be blank' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'São Paulo'
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: 'Avenida Paulista, 123'

    click_on 'Enviar'

    expect(Subsidiary.count).to eq 0
    expect(page).to have_content('CNPJ não pode ficar em branco')
  end

  scenario 'and cnpj must be unique' do
    Subsidiary.create!(name: 'São Paulo', cnpj: '123456789', address: 'Avenida Paulista, 123')

    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'São Paulo'
    fill_in 'CNPJ', with: '123456789'
    fill_in 'Endereço', with: 'Avenida Paulista, 123'

    click_on 'Enviar'

    expect(Subsidiary.count).to eq 1
    expect(page).to have_content('CNPJ já cadastrado')
  end
end
