class CarModelsController < ApplicationController
  def index
    @car_models = CarModel.all
  end

  def new
    @car_model = CarModel.new
  end

  def create
    @car_model = CarModel.new(car_model_params)
    return redirect_to @car_model if @car_model.save

    render :new
  end

  def show
    @car_model = CarModel.find(params[:id])
  end

  private

  def car_model_params
    params.require(:car_model).permit(:name, :manufacturer_id, :car_category_id, :fuel_type, :motorization, :year)
  end
end
