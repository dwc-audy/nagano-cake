class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer, only: [:show, :edit, :update]

  layout 'admin'

  def index
    @customers = Customer.all
  end

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer.id)
    else
      render 'edit'
    end
  end

  def search
    @value = params[:value]
    @column = params[:column]
    @how = params[:how]
    Customer.search_for(@value, @column, @how)
    render 'index'
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    list = [
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :postal_code,
      :address,
      :telephone_number,
      :email,
      :is_deleted
    ]
    params.require(:customer).permit(list)
  end
end
