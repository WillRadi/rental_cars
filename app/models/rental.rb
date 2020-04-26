class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category

  validate :end_date_must_be_greater_than_start_date
  validate :start_date_is_not_past
  validate :end_date_is_not_past

  before_create :create_code

  private

  def end_date_must_be_greater_than_start_date
    errors.add(:end_date, 'Data final deve ser maior do que data inicial') if start_is_greater_than_end?
  end

  def start_date_is_not_past
    errors.add(:start_date, 'Data inicial não pode ser menor do que o dia corrente') if start_date.past?
  end

  def end_date_is_not_past
    errors.add(:end_date, 'Data final deve ser maior do que o dia corrente') if end_date_past_or_today?
  end

  def start_is_greater_than_end?
    return if start_date.blank? || end_date.blank?

    start_date >= end_date
  end

  def end_date_past_or_today?
    end_date.today? || end_date.past?
  end

  def create_code
    self.code = SecureRandom.alphanumeric(6).upcase
  end
end
