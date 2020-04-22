require 'rails_helper'

RSpec.describe Rental, type: :model do
  context 'validation' do
    xit 'should validate start date presence' do
      rental = Rental.new(start_date: '', end_date: Date.today)
      rental.valid?

      expect(rental.errors[:start_date]).to include 'não pode ficar em branco'
    end
    it 'should validate end date is greater than start date' do
      rental = Rental.new(start_date: '21/04/2020', end_date: '20/04/2020')
      rental.valid?

      expect(rental.errors[:end_date]).to include 'Data final deve ser maior do que data inicial'
    end

    it 'should validate end date is not equal to start date' do
      rental = Rental.new(start_date: '21/04/2020', end_date: '21/04/2020')
      rental.valid?

      expect(rental.errors[:end_date]).to include 'Data final deve ser maior do que data inicial'
    end

    it 'should validate start date is not in the past' do
      rental = Rental.new(start_date: Date.yesterday, end_date: Date.yesterday)
      rental.valid?

      expect(rental.errors[:start_date]).to include 'Data inicial não pode ser menor do que o dia corrente'
    end

    it 'should validate end date is not today' do
      rental = Rental.new(end_date: Date.today, start_date: Date.today)
      rental.valid?

      expect(rental.errors[:end_date]).to include 'Data final deve ser maior do que o dia corrente'
    end

    it 'should validate end date is not past' do
      rental = Rental.new(end_date: Date.yesterday, start_date: Date.today)
      rental.valid?

      expect(rental.errors[:end_date]).to include 'Data final deve ser maior do que o dia corrente'
    end
  end
end
