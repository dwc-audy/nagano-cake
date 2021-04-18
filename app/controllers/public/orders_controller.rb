class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  
  def create
    @order = Order.new(order_params)
    if params[:back]
      render :new
    else @order.save!
      redirect_to orders_complete_path
    end
    
  end

  def index
    @customer = current_customer
		@orders = @customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirm
    @order = Order.new(order_params)

    if params[:order][:address_number]=="1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:address_number]=="2"

    elsif params[:order][:address_number]=="3"
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
      @order.postal_code = params[:order][:postal_code]
      @order.customer_id = current_customer.id
      if @order.save
      end
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save!
    redirect_to orders_complete_path
  end

  def complete

  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)

  end
end
