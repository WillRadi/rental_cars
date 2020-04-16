class Subsidiary < ApplicationRecord
  validates :cnpj, presence: true
  validates :cnpj, uniqueness: true
  validate :cnpj_must_be_valid

  private

  def cnpj_must_be_valid
    return if CNPJ.valid?(self.cnpj, strict: true)

    errors.add(:cnpj, 'CNPJ invalido')
  end
end
