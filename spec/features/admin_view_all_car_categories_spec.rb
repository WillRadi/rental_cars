require 'rails_helper'

feature 'Admin view all car categories' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@mail.com', password: '123456')
    c1 = CarCategory.create!(name: 'A', daily_rate: '100', car_insurance: '20', third_party_insurance: '20')
    c2 = CarCategory.create!(name: 'B', daily_rate: '200', car_insurance: '30', third_party_insurance: '25')

login_as user, scope: :user
    visit root_path
    click_on 'Categorias de Carros'

    expect(current_path).to eq car_categories_path
    expect(page).to have_link('Detalhes', href: car_category_path(c1.id))
    expect(page).to have_content('R$ 100,00')
    expect(page).to have_link('Detalhes', href: car_category_path(c2.id))
    expect(page).to have_content('R$ 200,00')
  end

  scenario 'with no categories' do
    user = User.create!(email: 'teste@mail.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Categorias de Carros'

    expect(page).to have_content('Nenhum(a) Categoria de carro encontrado(a)')
  end

  scenario 'and access show page through details link' do
    user = User.create!(email: 'teste@mail.com', password: '123456')
    c1 = CarCategory.create!(name: 'A', daily_rate: '100', car_insurance: '20', third_party_insurance: '20')

    login_as user, scope: :user
    visit root_path
    click_on 'Categorias de Carros'
    within("#row_#{c1.id}") do
      click_on 'Detalhes'
    end

    expect(page).to have_content('Categoria A')
  end
end
