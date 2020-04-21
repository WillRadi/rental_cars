require 'rails_helper'

feature 'user login' do
  xscenario 'successfully' do
    # User != Client
    user = User.create!(email: 'teste@mail.com', password: '123456')

    visit rooth_path
    click_on 'Entrar'

    fill_in 'Email', with: 'teste@mail.com'
    fill_in 'Senha', with: '123456'
    click_on 'Log in'


  end
end
