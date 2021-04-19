class Public::CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :withdraw]

  layout 'public'

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to customers_my_page_path
    else
      render 'edit'
    end
  end

  def unsubscribe
  end

  def withdraw
    @customer.update(is_deleted: true)
    redirect_to root_path
  end

  private

  def set_customer
    @customer = Customer.find(current_customer.id)
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
      :email
    ]
    params.require(:customer).permit(list)
  end

end
