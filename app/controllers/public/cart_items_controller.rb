class Public::CartItemsController < ApplicationController


  def index
    @cart_item = CartItem.where(customer_id: current_customer.id)
  end

  def create
    @cart_item =CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id

    if @cart_item.save
      redirect_to cart_items_path
    else
      flash[:alert] = "失敗"
      render :index
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end


end
