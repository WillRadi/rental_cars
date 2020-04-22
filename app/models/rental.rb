class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category

  validate :end_date_must_be_greater_than_start_date
  validate :start_date_is_not_past
  validate :end_date_is_not_past

  private

  def end_date_must_be_greater_than_start_date
    errors.add(:end_date, 'Data final deve ser maior do que data inicial') if start_is_greater_than_end?(self.start_date, self.end_date)
  end

  def start_date_is_not_past
    errors.add(:start_date, 'Data inicial não pode ser menor do que o dia corrente') if self.start_date.past?
  end

  def end_date_is_not_past
    errors.add(:end_date, 'Data final deve ser maior do que o dia corrente') if past_or_today?(self.end_date)
  end

  def start_is_greater_than_end?(start_date, end_date)
    return if start_date.blank? || end_date.blank?

    start_date >= end_date
  end

  def past_or_today?(date)
    date.today? || date.past?
  end
end
