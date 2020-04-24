require 'rails_helper'

RSpec.describe Client, type: :model do
  it 'should validate email' do
    client = Client.new(email: 'teste')
    client.valid?

    expect(client.errors[:email]).to include 'não é válido'
  end

  it 'should validate email without at sign' do
    client = Client.new(email: 'teste.com')
    client.valid?

    expect(client.errors[:email]).to include 'não é válido'
  end

  it 'should validate email without . smt' do
    client = Client.new(email: 'teste@gmail')
    client.valid?

    expect(client.errors[:email]).to include 'não é válido'
  end

  it 'should validate email without prefix' do
    client = Client.new(email: '@gmail.com')
    client.valid?

    expect(client.errors[:email]).to include 'não é válido'
  end

  it 'should email be valid' do
    client = Client.new(email: 'teste@gmail.com')
    client.valid?

    expect(client.errors[:email]).to be_blank
  end

  it 'should validate cpf' do
    client = Client.new(document: '123.123.123-67')
    client.valid?

    expect(client.errors[:document]).to include 'CPF inválido'
  end

  it 'should validate cpf incomplete' do
    client = Client.new(document: '650.602.700')
    client.valid?

    expect(client.errors[:document]).to include 'CPF inválido'
  end

  it 'should cpf be valid with special characters' do
    client = Client.new(document: '650.602.700-25')
    client.valid?

    expect(client.errors[:document]).to be_blank
  end

  it 'should cpf be valid without special characters' do
    client = Client.new(document: '65060270025')
    client.valid?

    expect(client.errors[:document]).to be_blank
  end
end
