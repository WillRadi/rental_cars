class Client < ApplicationRecord
  has_many :rentals

  validate :cpf_must_be_valid
  validate :email_must_be_valid

  def identification
    "#{name} - #{document}"
  end

  private

  def cpf_must_be_valid
    errors.add(:document, 'CPF inválido') unless CPF.valid?(self.document, strict: true)
  end

  def email_must_be_valid
    errors.add(:email, 'e-mail inválido') unless email?(self.email)
  end

  def email?(str)
    !!(str =~ /([\w].?)+@[a-z]+\.[a-z]+/i)
  end
end
