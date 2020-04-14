class Subsidiary < ApplicationRecord
  validates :cnpj, presence: { message: 'CNPJ não pode ficar em branco' }, uniqueness: { message: 'CNPJ já cadastrado' }
  validate :cnpj_must_be_valid

  private

  def cnpj_must_be_valid
    errors.add(:cnpj, 'CNPJ invalido') if CNPJ.valid?(:cnpj, strict: true)
  end
end
