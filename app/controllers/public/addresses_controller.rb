class Public::AddressesController < ApplicationController
  def index
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    render 'index'
  end

  def edit
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
