class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category

  validate :end_date_must_be_greater_than_start_date
  validate :start_date_is_not_past
  validate :end_date_is_not_past

  private

  def end_date_must_be_greater_than_start_date
    errors.add(:end_date, 'Data final deve ser maior do que data inicial') unless self.end_date > self.start_date
  end

  def start_date_is_not_past
    errors.add(:start_date, 'Data inicial não pode ser menor do que o dia corrente') unless self.start_date >= Date.today
  end

  def end_date_is_not_past
    errors.add(:end_date, 'Data final deve ser maior do que o dia corrente') unless self.end_date > Date.today
  end
end
