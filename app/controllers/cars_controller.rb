class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def new
    @car = Car.new
    @car_models = CarModel.all
  end

  def create
    @car = Car.new(car_params)
    @car_models = CarModel.all
    return redirect_to @car if @car.save

    render :new
  end

  # SE CLICAR NO SHOW A PARTIR DE OUTRO LUGAR... (VIA GET) o que acontece com a variável @car
  # ou seja, o params pega parâmetros de get e post?
  def show
    @car = Car.find(params[:id])
  end

  private

  def car_params
    params.require(:car).permit(:car_model_id, :license_plate, :color, :mileage)
  end
end
