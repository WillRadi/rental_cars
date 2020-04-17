require 'rails_helper'

describe Subsidiary, type: :model do
  context 'validation' do
    it 'invalid cnpj' do
      subsidiary = Subsidiary.new(name: 'Curitiba', cnpj:'21212', address: 'Rua dos bobos, 0')
      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('CNPJ invalido')
    end

    it 'cnpj must be valid' do
      subsidiary = Subsidiary.new(cnpj:'07.791.319/0001-21')
      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to be_empty
    end

    it 'cnpj must be valid without special characters' do
      subsidiary = Subsidiary.new(cnpj:'07791319000121')
      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to be_empty
    end
  end
end
