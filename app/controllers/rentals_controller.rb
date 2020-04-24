class RentalsController < ApplicationController
  def index
    @rentals = Rental.all
  end

  def new
    @rental = Rental.new
    @clients = Client.all
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

  private

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :client_id, :car_category_id)
  end
end
