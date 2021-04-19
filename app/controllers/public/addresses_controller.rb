class Public::AddressesController < ApplicationController
  before_action :set_address, only: [:destroy, :edit, :update]

  layout 'public'

  def index
    @addresses = current_customer.addresses
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    redirect_to addresses_path
  end

  def destroy
    @address.destroy
    redirect_to addresses_path
  end

  def edit
  end

  def update
    @address.update(address_params)
    redirect_to addresses_path
  end

  private

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
