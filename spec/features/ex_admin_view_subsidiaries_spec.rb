require 'rails_helper'

feature 'Administrator view subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'São Paulo', cnpj: '123456', address: 'Avenida Paulista, 123')
    Subsidiary.create!(name: 'Curitiba', cnpj: '654321', address: 'Avenida Mal. Floriano Peixoto, 123')

    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nome: São Paulo')
    expect(page).to have_content('CNPJ: 123456')
    expect(page).to have_content('Endereço: Avenida Paulista, 123')
    expect(page).to have_content('Nome: Curitiba')
    expect(page).to have_content('CNPJ: 654321')
    expect(page).to have_content('Endereço: Avenida Mal. Floriano Peixoto, 123')
  end

  scenario 'and there is no subsidiaries' do
    visit root_path
    click_on 'Filiais'

    expect(Subsidiary.count).to eq 0
    expect(page).to have_content('Nenhum registro encontrado')
  end
end
