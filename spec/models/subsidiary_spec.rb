require 'rails_helper'

describe Subsidiary, type: :model do
  context 'validation' do
    it 'cnpj must be valid' do
      subsidiary = Subsidiary.new(name: 'Curitiba', cnpj:'21212', address: 'Rua dos bobos, 0')
      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('CNPJ invalido')
    end
  end
end
