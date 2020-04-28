class Customer < ApplicationRecord
  has_many :rentals

  validate :cpf_must_be_valid
  validates :email, format: { with: /([\w].?)+@[a-z]+\.[a-z]+/i }

  def identification
    "#{name} - #{document}"
  end

  private

  def cpf_must_be_valid
    errors.add(:document, 'CPF inválido') unless CPF.valid?(self.document, strict: true)
  end
end
