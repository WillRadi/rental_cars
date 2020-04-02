class ManufacturersController < ApplicationController
  def index
    @manufacturer = Manufacturer.all
  end

  def show
    @manufacturer = Manufacturer.find(params[:name])
  end
end
