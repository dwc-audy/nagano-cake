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
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirm
    @order = Order.new(order_params)
  end

  def complete
  end
  
  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end
  
  def order_details_params
    params.require(:order_details).permit(:order_id, :item_id, :price, :making_status, :amount)
  end
end
