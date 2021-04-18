class Admin::OrdersController < ApplicationController


  def show
   @customer = Customer.find(params[:id])
   @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
      redirect_to  admin_order_path(@order)
  end

  def order_params
    params.require(:order).permit(:status)
  end


end
