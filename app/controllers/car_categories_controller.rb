class  CarCategoriesController < ApplicationController
  def new
    @car_category = CarCategory.new
  end

  def create
    @car_category = CarCategory.new(car_category_params)
    return redirect_to @car_category if @car_category.save

    render :new
  end

  def show
    @car_category = CarCategory.find(params[:id])
  end

  private

  def car_category_params
    params.require(:car_category).permit(:name, :daily_rate, :car_insurance, :third_party_insurance)
  end
end
