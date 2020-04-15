class Subsidiary < ApplicationRecord
  validates :cnpj, presence: true
  validates :cnpj, uniqueness: true
  validate :cnpj_must_be_valid

  private

  def cnpj_must_be_valid
    errors.add(:cnpj, 'CNPJ invalido') if CNPJ.valid?(:cnpj, strict: true)
  end
end
