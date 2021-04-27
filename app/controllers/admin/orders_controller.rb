class Admin::OrdersController < ApplicationController
  layout 'admin'

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.update(order_params)

    if @order.status == "入金確認"
      @order_details.update(making_status: 1)
      flash[:alert] = "入金ステータス更新しました"
    end
    redirect_to admin_order_path(@order)
  end

  def order_params
    params.require(:order).permit(:status)
  end
end
