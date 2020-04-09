require 'rails_helper'

feature 'Administrator view subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'São Paulo', cnpj: '123456', address: 'Avenida Paulista, 123')
    Subsidiary.create!(name: 'Curitiba', cnpj: '654321', address: 'Avenida Mal. Floriano Peixoto, 123')

    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('São Paulo')
    expect(page).to have_content('Curitiba')
  end

  scenario 'and there is no subsidiaries' do
    visit root_path
    click_on 'Filiais'

    expect(Subsidiary.count).to eq 0
    expect(page).to have_content('Nenhum registro encontrado')
  end

  scenario 'and view details' do
    sp = Subsidiary.create!(name: 'São Paulo', cnpj: '123456', address: 'Avenida Paulista, 123')
    ctba = Subsidiary.create!(name: 'Curitiba', cnpj: '654321', address: 'Avenida Mal. Floriano Peixoto, 123')

    visit root_path
    click_on 'Filiais'
    click_on 'São Paulo'

    expect(current_path).to eq subsidiary_path(sp.id)
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('CNPJ: 123456')
    expect(page).to have_content('Endereço: Avenida Paulista, 123')
    expect(page).not_to have_content('Curitiba')
  end
end
