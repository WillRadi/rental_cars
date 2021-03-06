class ManufacturersController < ApplicationController
  before_action :set_manufacturer, only: [:show, :edit, :update, :destroy]
  def index
    @manufacturers = Manufacturer.all
  end

  def show; end

  def new
    @manufacturer = Manufacturer.new
  end

  def edit; end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)
    return redirect_to @manufacturer if @manufacturer.save

    render :new
  end

  def update
    return redirect_to @manufacturer if @manufacturer.update(manufacturer_params)

    render :edit
  end

  def destroy
    @manufacturer.destroy

    redirect_to manufacturers_path
  end

  private

  def manufacturer_params
    params.require(:manufacturer).permit(:name)
  end

  def set_manufacturer
    @manufacturer = Manufacturer.find(params[:id])
  end
end
