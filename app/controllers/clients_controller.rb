class ClientsController < ApplicationController
  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    return redirect_to @client if @client.save

    render :new
  end

  def show
    @client = Client.find(params[:id])
  end

  private

  def client_params
    params.require(:client).permit(:name, :email, :document)
  end
end