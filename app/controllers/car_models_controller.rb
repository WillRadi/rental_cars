class CarModelsController < ApplicationController
  def index
    @car_models = CarModel.all
  end

  def new
    @car_model = CarModel.new
  end
end
