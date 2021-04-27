class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_address, only: [:destroy, :edit, :update]

  layout 'public'

  def index
    @addresses = current_customer.addresses.page(params[:page]).per(8)
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to addresses_path
    else
      @addresses = current_customer.addresses.page(params[:page]).per(8)
      render 'index'
    end
  end

  def destroy
    @address.destroy
    redirect_to addresses_path
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render 'edit'
    end
  end

  private

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
