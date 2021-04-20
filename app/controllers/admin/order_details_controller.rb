class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    if @order_detail.update(order_detail_params)
      
      redirect_to admin_order_path(@order)
    else
      redirect_to root_path
    end
    
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
