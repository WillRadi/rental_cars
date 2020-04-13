class Subsidiary < ApplicationRecord
  validates :cnpj, presence: { message: 'CNPJ não pode ficar em branco' }, uniqueness: { message: 'CNPJ já cadastrado' }
end
