class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    return redirect_to @customer if @customer.save

    render :new
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def search
    @word = params[:q]
    @customers = Customer.where("name LIKE ?", "%#{@word}%").or(Customer.where(document: @word))
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :document)
  end
end
