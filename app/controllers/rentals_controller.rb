class RentalsController < ApplicationController
  def index
    @rentals = Rental.all
  end

  def new
    @rental = Rental.new
    @customers = Customer.all
    @car_categories = CarCategory.all
  end

  def create
    @rental = Rental.new(rental_params)
    if @rental.save
      flash[:success] = 'Locação cadastrada com sucesso'
      return redirect_to rentals_path
    else
      render :new
    end
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def search
    @rentals = Rental.where(code: params[:q])
    render :index
  end

  def start
    @rental = Rental.find(params[:id])
    @available_cars = Car.where(car_model: @rental.car_category.car_models)
  end

  def confirm
    @rental = Rental.find(params[:id])
    @car = Car.find(params[:car_id])

    Rental.transaction do
      begin
        @rental.ongoing!
        @car.rented!
        CarRental.create!(rental: @rental, car: @car, start_date: Time.zone.now, user: current_user, daily_rate: @rental.car_category.daily_rate, car_insurance: @rental.car_category.car_insurance, third_party_insurance: @rental.car_category.third_party_insurance)
      rescue
        logger.error "Erro ao iniciar Locação #{@rental.code}"
      end
      redirect_to @rental
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :customer_id, :car_category_id)
  end
end
